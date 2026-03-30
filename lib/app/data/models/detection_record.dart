import 'package:cloud_firestore/cloud_firestore.dart';

class DetectionRecord {
  final String id;
  final String vehicleType;
  final String plateNumber;

  /// Isi field ini bisa berupa:
  /// - String kosong         : belum ada gambar
  /// - 'assets/images/...'  : gambar asset lokal (dummy / fallback)
  /// - base64 string         : gambar hasil capture yang disimpan di Firestore
  final String imageData;

  final DateTime detectedAt;
  final double confidence;

  const DetectionRecord({
    required this.id,
    required this.vehicleType,
    required this.plateNumber,
    required this.imageData,
    required this.detectedAt,
    required this.confidence,
  });

  /// true jika imageData adalah path asset Flutter (bukan base64)
  bool get isAsset => imageData.startsWith('assets/');

  String get formattedDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${detectedAt.day} ${months[detectedAt.month - 1]} ${detectedAt.year}';
  }

  Map<String, dynamic> toMap() => {
        'vehicleType': vehicleType,
        'plateNumber': plateNumber,
        'imageBase64': imageData,          // kunci Firestore = imageBase64
        'detectedAt': Timestamp.fromDate(detectedAt),
        'confidence': confidence,
      };

  factory DetectionRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DetectionRecord(
      id: doc.id,
      vehicleType: data['vehicleType'] as String? ?? '',
      plateNumber: data['plateNumber'] as String? ?? '',
      imageData: data['imageBase64'] as String? ?? '',  // baca dari imageBase64
      detectedAt: (data['detectedAt'] as Timestamp).toDate(),
      confidence: (data['confidence'] as num).toDouble(),
    );
  }
}
