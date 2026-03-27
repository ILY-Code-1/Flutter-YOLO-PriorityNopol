import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/animated_arrow.dart';
import '../../../core/widgets/detection_card.dart';
import '../controllers/main_controller.dart';

class HistoryPage extends StatelessWidget {
  final MainController controller;

  const HistoryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: AppSizes.spaceM),

          AnimatedArrow(
            direction: ArrowDirection.up,
            onTap: controller.goToHome,
          ),

          SizedBox(height: AppSizes.spaceS),

          const Text('Riwayat Deteksi', style: AppTextStyles.title),

          SizedBox(height: AppSizes.spaceL),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingPage),
                itemCount: controller.records.length,
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.spaceS),
                  child: DetectionCard(
                    record: controller.records[i],
                    onTap: () => controller.goToResult(controller.records[i]),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSizes.spaceL),
        ],
      ),
    );
  }
}
