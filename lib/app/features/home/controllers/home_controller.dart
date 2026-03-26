import 'package:get/get.dart';
import '../../../../app_routes.dart';

class HomeController extends GetxController {
  void goToDetection() {
    Get.toNamed(AppRoutes.detection);
  }

  void goToHistory() {
    Get.toNamed(AppRoutes.history);
  }
}
