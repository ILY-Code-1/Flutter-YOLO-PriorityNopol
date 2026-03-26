class DetectionRecord {
  final String id;
  final String vehicleType;
  final String plateNumber;
  final String imagePath;
  final DateTime detectedAt;
  final double confidence;

  const DetectionRecord({
    required this.id,
    required this.vehicleType,
    required this.plateNumber,
    required this.imagePath,
    required this.detectedAt,
    required this.confidence,
  });

  String get formattedDate {
    return '${detectedAt.day.toString().padLeft(2, '0')} - '
        '${detectedAt.month.toString().padLeft(2, '0')} - '
        '${detectedAt.year}';
  }
}
