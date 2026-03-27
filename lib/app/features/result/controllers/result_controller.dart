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
    // Get.offAllNamed membersihkan seluruh navigation stack lalu buka /home.
    // Kenapa offAllNamed, bukan back()?
    //   - User bisa sampai di sini dari 2 jalur:
    //       1. /home → /result  (stack: home, result)
    //       2. /home → /detection → /preview → /result  (stack: home, detection, preview, result)
    //   - offAllNamed memastikan di kedua kasus, stack bersih — hanya /home tersisa.
    //
    // arguments: {'initialPage': 1} memberi tahu MainController untuk langsung
    // menampilkan HistoryPage (page 1) ketika MainView dibuat ulang.
    Get.offAllNamed(AppRoutes.home, arguments: {'initialPage': 1});
  }
}
