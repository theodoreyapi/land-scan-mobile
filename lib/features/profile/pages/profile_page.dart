import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../login/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  color: appColor,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: ListTile(
                  leading: ClipOval(
                    child: CircleAvatar(
                      backgroundColor: appWhite,
                      child:
                          SharedPreferencesHelper().getString('photo')! == ""
                              ? FlutterLogo()
                              : Image.network(
                                SharedPreferencesHelper().getString('photo')!,
                              ),
                    ),
                  ),
                  title: Text(
                    SharedPreferencesHelper().getString('nom')!,
                    style: TextStyle(
                      color: appWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    "${SharedPreferencesHelper().getString('phone')!} | ${SharedPreferencesHelper().getString('email')}",
                    style: TextStyle(
                      color: appWhite,
                      fontWeight: FontWeight.normal,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              Gap(2.h),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          backgroundColor: appColor.withValues(alpha: .1),
                          child: Icon(Icons.settings_outlined, color: appColor),
                        ),
                        title: Text(
                          "Paramètres",
                          style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next, color: appColor),
                      ),
                    ),
                    Gap(1.h),
                    Container(
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          backgroundColor: appColor.withValues(alpha: .1),
                          child: Icon(Icons.lock_outline, color: appColor),
                        ),
                        title: Text(
                          "Paramètres mot de passe",
                          style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next, color: appColor),
                      ),
                    ),
                    Gap(1.h),
                    Container(
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          backgroundColor: appColor.withValues(alpha: .1),
                          child: Icon(Icons.info_outline, color: appColor),
                        ),
                        title: Text(
                          "FAQ / Support",
                          style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next, color: appColor),
                      ),
                    ),
                    Gap(4.h),
                    Container(
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: appWhite,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 300,
                                child: Padding(
                                  padding: EdgeInsets.all(4.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "Voulez-vous vraiment vous déconnecter ?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gap(2.h),
                                      Container(
                                        padding: EdgeInsets.all(2.w),
                                        decoration: BoxDecoration(
                                          color: appCardBlue.withValues(
                                            alpha: .1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3.w,
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.info_outline,
                                            color: appCardBlue,
                                          ),
                                          title: Text(
                                            "Cette action vous empêchera d'avoir "
                                            "accès a toutes les informations "
                                            "sur l'application",
                                            style: TextStyle(
                                              color: appCardBlue,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(2.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CancelButton(
                                              AppConstants.btnCancel,
                                              height: 10.w,
                                              fontSize: 15.sp,
                                              onPressed:
                                                  () => Navigator.pop(context),
                                            ),
                                          ),
                                          Gap(2.w),
                                          Expanded(
                                            child: SubmitButton(
                                              AppConstants.btnLogout,
                                              height: 10.w,
                                              fontSize: 15.sp,
                                              couleur: Colors.red,
                                              onPressed: () async {
                                                logoutUser();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.red.withValues(alpha: .1),
                          child: Icon(Icons.logout_outlined, color: Colors.red),
                        ),
                        title: Text(
                          "Se déconnecter",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logoutUser() async {
    final http.Response response = await http.get(
      Uri.parse(
        "${ApiUrls.getLogoutUrl}${SharedPreferencesHelper().getString('identifiant')!}",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      await SharedPreferencesHelper().clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } else {
      throw Exception("Impossible de vous déconnectez. Veuillez réessayer!!!");
    }
  }
}
