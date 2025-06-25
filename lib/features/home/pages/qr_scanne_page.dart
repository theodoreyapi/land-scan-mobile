import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';

class QrScannePage extends StatefulWidget {
  const QrScannePage({super.key});

  @override
  State<QrScannePage> createState() => _QrScannePageState();
}

class _QrScannePageState extends State<QrScannePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isProcessing = false;

  String scanMessage = "Message".toUpperCase();
  Color containerColor = appCardBlue;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isProcessing) {
        isProcessing = true;
        controller.pauseCamera(); // on arrête la caméra pendant le traitement
        scanUser(scanData); // on appelle la fonction
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> scanUser(Barcode scanData) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              const Expanded(child: Text('Validation en cours...')),
            ],
          ),
        );
      },
    );

    try {
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final response = await http.post(
        Uri.parse(ApiUrls.postEventScanUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': scanData.code,
          'agent': SharedPreferencesHelper().getString('identifiant')!,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);

        setState(() {
          scanMessage = responseData['message'] ?? "Validé avec succès";
          containerColor = Colors.green;
        });
      } else {
        Navigator.pop(context);
        setState(() {
          scanMessage = responseData['message'] ?? "Échec de validation";
          containerColor = Colors.red;
        });
      }

      controller?.resumeCamera();
      isProcessing = false;
    } catch (e) {
      Navigator.pop(context);
      setState(() {
        scanMessage = "Erreur de connexion ${e}";
        containerColor = Colors.orange;
      });

      controller?.resumeCamera();
      isProcessing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appColor),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: appWhite,
                    overlayColor: Colors.grey.shade500.withOpacity(0.6),
                    borderRadius: 2,
                    borderLength: 30,
                    borderWidth: 10,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.flash_on, color: Colors.black),
                      onPressed: () async {
                        await controller?.toggleFlash();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: containerColor,
              child: Center(
                child: Text(
                  scanMessage,
                  style: TextStyle(
                    color: appWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
