import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/utils.dart';
import '../../../models/history/history_model.dart';
import '../../../models/states/state_model.dart';
import '../homes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  List<Events> allPharmacies = [];
  late Future<List<Events>> _futurePharmacies;
  late Future<List<States>> _futureStates;

  @override
  void initState() {
    super.initState();
    _futurePharmacies = fetchPharmacie();
    _futureStates = fetchStates();
  }

  void _refreshData() {
    setState(() {
      _futurePharmacies = Future.value(allPharmacies);
    });
  }

  Future<List<Events>> fetchPharmacie() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getListEventUrl}${SharedPreferencesHelper().getString('identifiant')!}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> contentList = json.decode(
        utf8.decode(response.bodyBytes),
      );

      //debugPrint(contentList.toString());

      try {
        List<Events> pharmacies =
            contentList
                .map((item) => Events.fromJson(item as Map<String, dynamic>))
                .toList();
        return pharmacies;
      } catch (e) {
        throw Exception("Erreur lors de la conversion JSON");
      }
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  Future<List<States>> fetchStates() async {
    debugPrint(
      "${ApiUrls.getStateUrl}${SharedPreferencesHelper().getString('identifiant')!}",
    );
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getStateUrl}${SharedPreferencesHelper().getString('identifiant')!}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> contentMap = json.decode(
      utf8.decode(response.bodyBytes),
    );

    debugPrint("JSON $contentMap");

    try {
      return [States.fromJson(contentMap)];
    } catch (e) {
      throw Exception("Erreur lors de la conversion JSON");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<States>>(
                  future: _futureStates,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Container();
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container();
                    }

                    States state = snapshot.data!.first;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: appCardOrange,
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Evénements",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Gap(1.h),
                                    Text(
                                      "${state.totalEvenements ?? 0}",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(2.w),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: appCardBlue,
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tickets",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Gap(1.h),
                                    Text(
                                      "${state.totalTickets ?? 0}",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(1.h),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: appCardGreen,
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tickets Scannés",
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: 15.sp,
                                ),
                              ),
                              Text(
                                "${state.ticketsScannes ?? 0}",
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(2.h),
                      ],
                    );
                  },
                ),
                Text(
                  "Evénements",
                  style: TextStyle(
                    color: appColorBlack,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<List<Events>>(
                  future: _futurePharmacies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Pas de pharmacie disponible pour cette commune",
                        ),
                      );
                    }

                    allPharmacies = snapshot.data!;

                    if (allPharmacies.isEmpty) {
                      return Center(child: Text("Pas d'évènement disponible"));
                    }

                    return ListView.builder(
                      itemCount: allPharmacies.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final contact = allPharmacies[index];
                        return ClipRect(
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
                                      borderRadius: BorderRadius.circular(3.w),
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
                                      borderRadius: BorderRadius.circular(3.w),
                                      color: appWhite,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contact.porteName!,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          contact.eventName!,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: appColorBlack,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${contact.eventDate!} à ${contact.eventTime!}",
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: appCardBlue,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "Nbre ticket: ${contact.totalTickets}",
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
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'Ajouter',
        tooltip: 'Ajouter',
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
