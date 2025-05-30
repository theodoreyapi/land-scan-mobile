import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:ticket_valide/core/themes/themes.dart';
import 'package:ticket_valide/features/notes/pages/note_page.dart';

class DetailNotePage extends StatefulWidget {
  Produits? details;

  DetailNotePage({super.key, this.details});

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.details!.name),
        centerTitle: false,
        backgroundColor: appColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.w),
                child: Image.asset(
                  widget.details!.facadeImage,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.stadium_outlined,
                        color: appCardBlue,
                        size: 80,
                      ),
                    );
                  },
                ),
              ),
            ),
            Gap(2.h),
            Text(
              widget.details!.categorie,
              style: TextStyle(
                color: appColorBlack,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(2.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attendances",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ticket déjà lu",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mauvaise porte",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ticket inconnu",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              color: appCardBlue,
              child: Center(
                child: Text(
                  "Nombre auto".toUpperCase(),
                  style: TextStyle(
                    color: appWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
