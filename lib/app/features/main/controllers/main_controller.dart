import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';

class MainController extends GetxController {
  // PageController dari Flutter yang kita kelola manual
  late final PageController pageController;

  final RxList<DetectionRecord> records = <DetectionRecord>[].obs;

  // Kategori yang sedang dipilih; 'Semua' berarti tidak ada filter
  final RxString selectedCategory = 'Semua'.obs;

  static const List<String> categories = [
    'Semua',
    'Ambulance',
    'Police',
    'Fire Truck',
  ];

  List<DetectionRecord> get filteredRecords {
    if (selectedCategory.value == 'Semua') return records;
    return records
        .where((r) => r.vehicleType == selectedCategory.value)
        .toList();
  }

  void setCategory(String? value) {
    if (value != null) selectedCategory.value = value;
  }

  // StreamSubscription disimpan agar bisa di-cancel saat controller di-dispose
  StreamSubscription<QuerySnapshot>? _recordsSub;

  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final initialPage =
        (args is Map ? args['initialPage'] as int? : null) ?? 0;

    pageController = PageController(initialPage: initialPage);
    _listenToRecords();
  }

  @override
  void onClose() {
    _recordsSub?.cancel();
    pageController.dispose();
    super.onClose();
  }

  /// Real-time stream dari Firestore — diurutkan terbaru ke terlama.
  /// Setiap ada perubahan di Firestore (insert/update/delete),
  /// records otomatis terupdate dan UI rebuild via Obx.
  void _listenToRecords() {
    _recordsSub = _firestore
        .collection('vehicle_detection')
        .orderBy('detectedAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        records.assignAll(
          snapshot.docs.map(DetectionRecord.fromFirestore).toList(),
        );
      },
      onError: (_) {
        // Firestore error (offline, permission) — biarkan list kosong
      },
    );
  }

  // Scroll ke HistoryPage (page 1)
  void goToHistory() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  // Scroll kembali ke HomePage (page 0)
  void goToHome() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void goToDetection() {
    Get.toNamed(AppRoutes.detection);
  }

  void goToResult(DetectionRecord record) {
    Get.toNamed(AppRoutes.result, arguments: record);
  }
}
