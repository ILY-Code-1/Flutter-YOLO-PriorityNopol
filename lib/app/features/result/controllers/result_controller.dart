import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';

class ResultController extends GetxController {
  final Rxn<DetectionRecord> record = Rxn<DetectionRecord>();

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is DetectionRecord) record.value = arg;
  }

  void goToHistory() {
    Get.offNamed(AppRoutes.history);
  }
}
