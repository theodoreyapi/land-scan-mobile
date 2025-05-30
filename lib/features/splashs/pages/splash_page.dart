import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ticket_valide/core/constants/constants.dart';

import '../../../core/themes/themes.dart';
import '../../login/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadingValue = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _updateLoadingProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Scannons vos tickets",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateLoadingProgress() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (loadingValue >= 1) {
        _navigateToNextScreen();
        return;
      }
      loadingValue += 0.1;
      setState(() {});
      _updateLoadingProgress();
    });
  }

  Future<void> _navigateToNextScreen() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}
