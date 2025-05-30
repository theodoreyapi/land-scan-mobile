import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/themes.dart';
import '../../../../core/widgets/widgets.dart';
import '../../menus/menus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  var login = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppConstants.appName.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),
              Gap(2.h),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: appWhite,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppConstants.btnNext,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                "Remplissez les champs avec les ID fournir par l'administrateur",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: appColorBlack,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(2.h),
                        InputText(
                          hintText: "Identifiant",
                          keyboardType: TextInputType.text,
                          controller: login,
                          validatorMessage: "Veuillez saisir votre identifiant",
                        ),
                        Gap(2.h),
                        InputPassword(
                          hintText: "Mot de passe",
                          controller: password,
                          validatorMessage:
                              "Veuillez saisir votre mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                        Gap(1.h),
                        SubmitButton(
                          AppConstants.btnLogin,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MenuPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  action: SnackBarAction(
                                    label: 'Fermer',
                                    onPressed: () {
                                      // Code to execute.
                                    },
                                  ),
                                  content: const Text(
                                    "Veuillez remplir tous les champs",
                                  ),
                                  duration: const Duration(milliseconds: 5000),
                                  width: 280.0,
                                  // Width of the SnackBar.
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
