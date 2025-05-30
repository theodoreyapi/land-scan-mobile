import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../../homes/homes.dart';
import '../notes.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class Produits {
  final int id;
  final String categorie;
  final String name;
  final String price;
  final String date;
  final String facadeImage;

  Produits({
    required this.id,
    required this.categorie,
    required this.name,
    required this.price,
    required this.date,
    required this.facadeImage,
  });
}

class _NotePageState extends State<NotePage> {
  var searchController = TextEditingController();

  late List<Produits> allProduitss = [
    Produits(
      id: 1,
      categorie: "Porte 04",
      name: "CAN 2025",
      price: "15",
      date: "15/05/2025",
      facadeImage: "assets/images/garde.png",
    ),
    Produits(
      id: 2,
      categorie: "Porte 04",
      name: "Championnat 2025",
      date: "20/05/2025",
      price: "30",
      facadeImage: "assets/images/garde.png",
    ),
    Produits(
      id: 3,
      categorie: "Porte 08",
      name: "Match amical",
      date: "30/05/2025",
      price: "10",
      facadeImage: "assets/images/garde.png",
    ),
    Produits(
      id: 4,
      categorie: "Porte 15",
      name: "Sponsor",
      date: "01/06/2025",
      price: "20",
      facadeImage: "assets/images/garde.png",
    ),
  ];
  List<Produits> filteredProduitss = [];
  bool isLoading = false;
  late Future<List<Produits>> _futureProduitss;

  @override
  void initState() {
    super.initState();
    _futureProduitss = Future.value(allProduitss);
    searchController.addListener(_filterProduitss);
  }

  void _filterProduitss() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProduitss =
          allProduitss
              .where((commune) => commune.name.toLowerCase().contains(query))
              .toList();
    });
  }

  void _refreshData() {
    setState(() {
      _futureProduitss = Future.value(allProduitss);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                child: FutureBuilder<List<Produits>>(
                  future: _futureProduitss,
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

                    if (snapshot.hasData) {
                      allProduitss = snapshot.data!;
                      // Appliquer filtre si champ recherche non vide
                      filteredProduitss =
                          searchController.text.isEmpty
                              ? allProduitss
                              : allProduitss
                                  .where(
                                    (commune) =>
                                        commune.name.toLowerCase().contains(
                                          searchController.text.toLowerCase(),
                                        ),
                                  )
                                  .toList();

                      if (filteredProduitss.isEmpty) {
                        return Center(
                          child: Text("Pas de pharmacie disponible"),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredProduitss.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final contact = filteredProduitss[index];
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
                                          child: Image.asset(
                                            contact.facadeImage,
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
                                            Text(
                                              contact.categorie,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              contact.name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: appColorBlack,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              contact.date,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: appCardBlue,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "Nbre ticket: ${contact.price}",
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
