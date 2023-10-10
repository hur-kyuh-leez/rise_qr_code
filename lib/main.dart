import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rise_qr_code/screens/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Rise QR code',
      home: Scaffold(
        body: QrScanner(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
