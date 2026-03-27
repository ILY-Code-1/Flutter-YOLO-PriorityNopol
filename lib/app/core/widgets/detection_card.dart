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
          horizontal: AppSizes.paddingPage * 0.7,
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
            Container(
              width: AppSizes.iconBgMedium,
              height: AppSizes.iconBgMedium,
              decoration: BoxDecoration(
                color: AppColors.iconBgPurple,
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: const Icon(
                Icons.image_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: AppSizes.spaceL),
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
}
