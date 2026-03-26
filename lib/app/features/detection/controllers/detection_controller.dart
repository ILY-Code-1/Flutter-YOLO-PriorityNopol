import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_routes.dart';

class DetectionController extends GetxController {
  final RxString selectedImagePath = ''.obs;
  final _picker = ImagePicker();

  Future<void> pickFromCamera() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (file != null) {
      selectedImagePath.value = file.path;
      await Future.delayed(const Duration(milliseconds: 300));
      Get.toNamed(AppRoutes.preview, arguments: file.path);
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) {
      selectedImagePath.value = file.path;
      await Future.delayed(const Duration(milliseconds: 300));
      Get.toNamed(AppRoutes.preview, arguments: file.path);
    }
  }

  void goBack() => Get.back();
}
