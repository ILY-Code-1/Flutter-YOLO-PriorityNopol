import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';
import 'package:http_parser/http_parser.dart';

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

  static const _apiUrl =
      'https://yusnar.my.id/py-yolo-nopol/api/v1/detect';

  static const _allowedVehicles = {'ambulance', 'police', 'fire_truck'};

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

  /// Format raw plate number: "B1234XYZ" → "B 1234 XYZ"
  /// Splits into: leading letters · digits · trailing letters
  String _formatPlateNumber(String raw) {
    final match =
        RegExp(r'^([A-Za-z]+)(\d+)([A-Za-z]+)$').firstMatch(raw.trim());
    if (match == null) return raw; // return as-is if pattern doesn't match
    return '${match.group(1)} ${match.group(2)} ${match.group(3)}';
  }

  // Kirim ke API deteksi YOLOv8, simpan ke Firestore, navigasi ke ResultView
  Future<void> submit() async {
    if (capturedImagePath.value.isEmpty) return;

    isLoading.value = true;

    try {
      // --- Multipart POST ---
      final request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

      final String path = capturedImagePath.value.toLowerCase();
      MediaType mediaType;
      if (path.endsWith('.png')) {
        mediaType = MediaType('image', 'png');
      } else if (path.endsWith('.jpg') || path.endsWith('.jpeg')) {
        mediaType = MediaType('image', 'jpeg');
      } else {
        mediaType = MediaType('image', 'jpeg');
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          capturedImagePath.value,
          contentType: mediaType,
        ),
      );

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode != 200) {
        throw HttpException(
          'HTTP ${streamedResponse.statusCode}: $responseBody',
        );
      }

      final Map<String, dynamic> json = jsonDecode(responseBody);
      final bool plateDetected = json['plate_detected'] as bool? ?? false;

      // --- Case 1: Not detected ---
      if (!plateDetected) {
        isLoading.value = false;
        Get.snackbar(
          'Gagal',
          'Kendaraan tidak terdeteksi',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutes.detection);
        isCaptured.value = false;
        return;
      }

      // --- Case 2: Detected ---
      final String vehicle =
          (json['vehicle'] as String? ?? '').toLowerCase();
      if (!_allowedVehicles.contains(vehicle)) {
        isLoading.value = false;
        Get.snackbar(
          'Gagal',
          'Tipe kendaraan tidak dikenali: $vehicle',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final String rawPlate = json['plate_number'] as String? ?? '';
      final String formattedPlate = _formatPlateNumber(rawPlate);
      final double confidence =
          (json['confidence'] as num? ?? 0).toDouble();

      // Build imageData as base64
      final bytes = await File(capturedImagePath.value).readAsBytes();
      final String imageData =
          'data:image/jpeg;base64,${base64Encode(bytes)}';

      final result = DetectionRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        vehicleType: vehicle,
        plateNumber: formattedPlate,
        imageData: imageData,
        detectedAt: DateTime.now(),
        confidence: confidence,
      );

      // Simpan ke Firestore collection 'vehicle_detection'
      await _firestore
          .collection('vehicle_detection')
          .doc(result.id)
          .set(result.toMap());

      isLoading.value = false;
      Get.toNamed(AppRoutes.result, arguments: result);
    } on SocketException {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Tidak ada koneksi internet',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TimeoutException {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Koneksi timeout, coba lagi',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    // CameraController adalah resource native — wajib dispose
    cameraController?.dispose();
    super.onClose();
  }
}
