import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/themes.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../core/utils/utils.dart';
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
                          keyboardType: TextInputType.phone,
                          controller: login,
                          validatorMessage: "Veuillez saisir votre identifiant",
                        ),
                        Gap(1.h),
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
                        Gap(2.h),
                        SubmitButton(
                          AppConstants.btnLogin,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loginUser(context);
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Veuillez remplir tous les champs",
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

  Future<void> loginUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              const Expanded(child: Text('Connexion en cours...')),
            ],
          ),
        );
      },
    );

    try {
      // Autoriser les certificats auto-signés (attention en production)
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final response = await http.post(
        Uri.parse(ApiUrls.postLoginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login.text, 'password': password.text}),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        await Future.wait([
          SharedPreferencesHelper().saveString(
            'identifiant',
            responseData['identifiant'].toString(),
          ),
          SharedPreferencesHelper().saveString('nom', responseData['nom']),
          SharedPreferencesHelper().saveString('phone', responseData['phone']),
          SharedPreferencesHelper().saveString('email', responseData['email']),
          SharedPreferencesHelper().saveString('photo', responseData['photo']),
        ]);

        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
          (route) => false,
        );
      } else {
        Navigator.pop(context);
        SnackbarHelper.showError(context, responseData['message']);
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
    }
  }
}
