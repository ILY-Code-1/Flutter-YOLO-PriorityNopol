import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../data/models/detection_record.dart';

class HistoryController extends GetxController {
  final RxList<DetectionRecord> records = <DetectionRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecords();
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

  void goBack() => Get.back();

  void goToResult(DetectionRecord record) {
    Get.toNamed(AppRoutes.result, arguments: record);
  }
}
