import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';

class DetectionController extends GetxController {
  // CameraController dari package camera — bukan GetX, harus di-dispose manual
  CameraController? cameraController;

  // true = kamera sudah siap ditampilkan
  final RxBool isCameraReady = false.obs;

  // true = user sudah capture/upload, box menampilkan foto diam
  final RxBool isCaptured = false.obs;

  // path foto hasil capture atau upload galeri
  final RxString capturedImagePath = ''.obs;

  // true = sedang proses submit, tampilkan overlay loading
  final RxBool isLoading = false.obs;

  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraReady.value = true;
    } catch (_) {
      // Kamera tidak tersedia (emulator, permission ditolak, dll)
    }
  }

  // Dipanggil oleh tombol shutter — capture dari live feed
  Future<void> capture() async {
    if (cameraController == null || !isCameraReady.value) return;
    try {
      final XFile file = await cameraController!.takePicture();
      capturedImagePath.value = file.path;
      isCaptured.value = true;
    } catch (_) {}
  }

  // Dipanggil oleh tombol upload — pilih dari galeri
  Future<void> pickFromGallery() async {
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) {
      capturedImagePath.value = file.path;
      isCaptured.value = true;
    }
  }

  // Reset ke live camera feed
  void retake() {
    capturedImagePath.value = '';
    isCaptured.value = false;
  }

  // Kirim ke ResultView — simpan ke Firestore lalu navigasi
  Future<void> submit() async {
    isLoading.value = true;

    // TODO: ganti delay dengan pemanggilan API deteksi YOLOv8 yang nyata
    await Future.delayed(const Duration(seconds: 2));

    String imageData;
    if (capturedImagePath.value.isNotEmpty) {
      final bytes = await File(capturedImagePath.value).readAsBytes();
      imageData = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    } else {
      imageData = 'assets/images/ambulance.webp';
    }

    final result = DetectionRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      vehicleType: 'Ambulance',
      plateNumber: 'B 1234 XYZ',
      imageData: imageData,
      detectedAt: DateTime.now(),
      confidence: 0.94,
    );

    // Simpan ke Firestore collection 'vehicle_detection'
    // doc ID = result.id agar mudah di-query ulang bila perlu
    await _firestore
        .collection('vehicle_detection')
        .doc(result.id)
        .set(result.toMap());

    isLoading.value = false;
    Get.toNamed(AppRoutes.result, arguments: result);
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    // CameraController adalah resource native — wajib dispose
    cameraController?.dispose();
    super.onClose();
  }
}
