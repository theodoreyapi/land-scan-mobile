import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';

class QrScannePage extends StatefulWidget {
  const QrScannePage({super.key});

  @override
  State<QrScannePage> createState() => _QrScannePageState();
}

class _QrScannePageState extends State<QrScannePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appColor),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: appWhite,
                overlayColor: Colors.grey.shade500.withValues(alpha: 0.6),
                borderRadius: 2,
                borderLength: 30,
                borderWidth: 10,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: appCardBlue,
              child: Center(
                child:
                    (result != null)
                        ? Text(
                          'Barcode Type: ${describeIdentity(result!.format)}   Data: ${result!.code}',
                        )
                        : Text(
                          "Message".toUpperCase(),
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
