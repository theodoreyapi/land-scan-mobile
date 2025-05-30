import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/themes/themes.dart';
import 'package:sizer/sizer.dart';
import '../homes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Produits {
  final int id;
  final String categorie;
  final String name;
  final String price;
  final String facadeImage;

  Produits({
    required this.id,
    required this.categorie,
    required this.name,
    required this.price,
    required this.facadeImage,
  });
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool _isVisible = true;

  final List<Produits> allProduitss = [
    Produits(
      id: 1,
      categorie: "Porte 04",
      name: "CAN 2025",
      price: "15",
      facadeImage: "assets/images/garde.png",
    ),
    Produits(
      id: 2,
      categorie: "Porte 04",
      name: "Championnat 2025",
      price: "30",
      facadeImage: "assets/images/garde.png",
    ),
    Produits(
      id: 3,
      categorie: "Porte 08",
      name: "Match amical",
      price: "10",
      facadeImage: "assets/images/garde.png",
    ),
    Produits(
      id: 4,
      categorie: "Porte 15",
      name: "Sponsor",
      price: "20",
      facadeImage: "assets/images/garde.png",
    ),
  ];

  List<Produits> filteredProduitss = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProduits();
  }

  void loadProduits() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        filteredProduitss = List.from(allProduitss);
        isLoading = false;
      });
    });
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
                              "5",
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
                              "10",
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
                        style: TextStyle(color: appWhite, fontSize: 15.sp),
                      ),
                      Text(
                        "8",
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
                Text(
                  "Evénements",
                  style: TextStyle(
                    color: appColorBlack,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : filteredProduitss.isEmpty
                    ? Center(child: Text("Pas de produit disponible"))
                    : ListView.builder(
                      itemCount: filteredProduitss.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final contact = filteredProduitss[index];
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
                                      borderRadius: BorderRadius.circular(3.w),
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
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: appColorBlack,
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
            //  _refreshNotes();
          }
        },
        child: Icon(Icons.qr_code_scanner_outlined, color: appWhite),
      ),
    );
  }
}
