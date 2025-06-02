import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../../../models/history/history_model.dart';
import '../../home/homes.dart';
import '../notes.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  var searchController = TextEditingController();

  List<Events> allPharmacies = [];
  List<Events> filteredPharmacies = [];
  bool isLoading = false;
  late Future<List<Events>> _futurePharmacies;

  String afficheOne = "";
  String afficheTwo = "";

  @override
  void initState() {
    super.initState();
    _futurePharmacies = fetchPharmacie();
    searchController.addListener(_filterPharmacies);
  }

  void _filterPharmacies() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredPharmacies =
          allPharmacies
              .where((commune) => commune.eventName!.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<List<Events>> fetchPharmacie() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getListEventScanUrl}${SharedPreferencesHelper().getString('identifiant')!}",
      ),
      headers: {
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> contentList = json.decode(
        utf8.decode(response.bodyBytes),
      );

      try {
        List<Events> pharmacies =
        contentList
            .map(
              (item) =>
                  Events.fromJson(item as Map<String, dynamic>),
        )
            .toList();
        return pharmacies;
      } catch (e) {
        throw Exception("Erreur lors de la conversion JSON");
      }
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  void _refreshData() {
    setState(() {
      _futurePharmacies = Future.value(allPharmacies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: .1,
                      blurRadius: 8,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: InputText(
                  hintText: "Rechercher un événement",
                  colorFille: appWhite,
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  prefixIcon: Icon(Icons.search_outlined, color: appColorBlack),
                  validatorMessage: "Veuillez saisir le nom de l'événement",
                ),
              ),
              Gap(2.h),
              Expanded(
                child: FutureBuilder<List<Events>>(
                  future: _futurePharmacies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Pas d'évènement scanné disponible",
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      allPharmacies = snapshot.data!;
                      filteredPharmacies =
                          searchController.text.isEmpty
                              ? allPharmacies
                              : allPharmacies
                                  .where(
                                    (commune) =>
                                        commune.eventName!.toLowerCase().contains(
                                          searchController.text.toLowerCase(),
                                        ),
                                  )
                                  .toList();

                      if (filteredPharmacies.isEmpty) {
                        return Center(
                          child: Text("Pas d'évènement scanné disponible"),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredPharmacies.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final contact = filteredPharmacies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          DetailNotePage(details: contact),
                                ),
                              );
                            },
                            child: ClipRect(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.only(bottom: 2.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.w),
                                  color: appCardBlue.withValues(alpha: .15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            3.w,
                                          ),
                                          child: Image.network(
                                            contact.eventImage!,
                                            height: 70,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Icon(
                                                Icons.stadium_outlined,
                                                color: appCardBlue,
                                                size: 80,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(1.h),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(13),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            3.w,
                                          ),
                                          border: Border.all(color: appColor),
                                          color: appWhite,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                           /* Text(
                                              contact.categorie,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),*/
                                            Text(
                                              contact.eventName!,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: appColorBlack,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              contact.eventDate!,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: appCardBlue,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "Nbre ticket: ${contact.tickets!.length}",
                                              style: TextStyle(
                                                color: appColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return Center(child: Text("Aucune donnée disponible"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'Scan',
        tooltip: 'Scan',
        backgroundColor: appColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrScannePage()),
          );

          if (result == true) {
            _refreshData();
          }
        },
        child: Icon(Icons.qr_code_scanner_outlined, color: appWhite),
      ),
    );
  }
}
