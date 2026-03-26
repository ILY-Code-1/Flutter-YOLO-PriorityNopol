import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_pages.dart';

void main() {
  runApp(const PrioScanApp());
}

class PrioScanApp extends StatelessWidget {
  const PrioScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PrioScan',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
    );
  }
}
