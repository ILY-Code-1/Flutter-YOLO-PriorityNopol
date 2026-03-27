import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';

class MainController extends GetxController {
  // PageController milik GetX bukan Flutter — ini adalah PageController dari Flutter
  // yang kita kelola manual agar bisa memanggil animateToPage()
  late final PageController pageController;

  final RxList<DetectionRecord> records = <DetectionRecord>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Cek apakah ada argumen initialPage dari navigasi lain (misal: dari ResultView)
    // Jika tidak ada argumen, mulai dari page 0 (HomePage)
    final args = Get.arguments;
    final initialPage =
        (args is Map ? args['initialPage'] as int? : null) ?? 0;

    pageController = PageController(initialPage: initialPage);
    loadRecords();
  }

  @override
  void onClose() {
    // PageController adalah resource Flutter — harus di-dispose manual
    // GetxController tidak tahu soal ini, kita tanggung jawab sendiri
    pageController.dispose();
    super.onClose();
  }

  // Scroll ke HistoryPage (page 1) — ini yang menggantikan Get.toNamed('/history')
  void goToHistory() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  // Scroll kembali ke HomePage (page 0) — menggantikan Get.back()
  void goToHome() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  // Navigasi ke DetectionView — ini tetap route baru (bukan PageView)
  void goToDetection() {
    Get.toNamed(AppRoutes.detection);
  }

  // Navigasi ke ResultView dengan membawa data record
  void goToResult(DetectionRecord record) {
    Get.toNamed(AppRoutes.result, arguments: record);
  }

  void loadRecords() {
    records.assignAll([
      DetectionRecord(
        id: '1',
        vehicleType: 'Ambulance',
        plateNumber: 'B 1234 XYZ',
        imagePath: '',
        detectedAt: DateTime.now(),
        confidence: 0.94,
      ),
      DetectionRecord(
        id: '2',
        vehicleType: 'Police',
        plateNumber: 'B 5678 ABC',
        imagePath: '',
        detectedAt: DateTime.now(),
        confidence: 0.91,
      ),
      DetectionRecord(
        id: '3',
        vehicleType: 'Fire Truck',
        plateNumber: 'D 9999 ZZ',
        imagePath: '',
        detectedAt: DateTime.now(),
        confidence: 0.88,
      ),
    ]);
  }
}
