import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';

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
                  leading: CircleAvatar(
                    backgroundColor: appWhite,
                    child: FlutterLogo(),
                  ),
                  title: Text(
                    "Théodore YAPI",
                    style: TextStyle(
                      color: appWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  subtitle: Text(
                    "Développeur Mobile",
                    style: TextStyle(
                      color: appWhite,
                      fontWeight: FontWeight.normal,
                      fontSize: 13.sp,
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: appWhite,
                    radius: 4.w,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 4.w,
                        color: appColor,
                      ),
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
                        onTap: () {},
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
}
