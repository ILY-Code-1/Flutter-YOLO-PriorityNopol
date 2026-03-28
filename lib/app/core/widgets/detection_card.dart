import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import '../../data/models/detection_record.dart';

class DetectionCard extends StatelessWidget {
  final DetectionRecord record;
  final VoidCallback? onTap;

  const DetectionCard({
    super.key,
    required this.record,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingPage * 0.7,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail kendaraan — asset, file lokal, atau fallback icon
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              child: SizedBox(
                width: AppSizes.iconBgMedium,
                height: AppSizes.iconBgMedium,
                child: _buildThumbnail(record.vehicleType),
              ),
            ),

            SizedBox(width: context.spaceL),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(record.vehicleType, style: AppTextStyles.vehicleName),
                  const SizedBox(height: 4),
                  Text(record.plateNumber, style: AppTextStyles.plateNumber),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Mapping vehicleType → asset thumbnail yang selalu tersedia,
  // sehingga thumbnail tetap muncul meskipun imagePath adalah
  // path lokal yang sudah tidak bisa diakses (misal: setelah data
  // diambil dari Firestore di session berbeda).
  static const _thumbnailAssets = {
    'Ambulance': 'assets/images/ambulance.webp',
    'Police': 'assets/images/police.webp',
    'Fire Truck': 'assets/images/fireman.webp',
  };

  Widget _buildThumbnail(String vehicleType) {
    final asset = _thumbnailAssets[vehicleType];
    if (asset != null) {
      return Image.asset(asset, fit: BoxFit.cover);
    }
    // vehicleType tidak dikenali → fallback icon ungu
    return Container(
      color: AppColors.iconBgPurple,
      child: const Icon(Icons.directions_car_rounded,
          color: Colors.white, size: 24),
    );
  }
}
