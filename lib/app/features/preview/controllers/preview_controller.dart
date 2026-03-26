import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';

class PreviewController extends GetxController {
  final RxString imagePath = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    imagePath.value = Get.arguments as String? ?? '';
  }

  void retake() => Get.back();

  Future<void> submit() async {
    isLoading.value = true;

    // Simulate detection processing
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    final result = DetectionRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      vehicleType: 'Ambulance',
      plateNumber: 'B 1234 XYZ',
      imagePath: imagePath.value,
      detectedAt: DateTime.now(),
      confidence: 0.94,
    );

    Get.toNamed(AppRoutes.result, arguments: result);
  }
}
