import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/animated_arrow.dart';
import '../../../core/widgets/detection_card.dart';
import '../../../core/widgets/gradient_background.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Up arrow — go back to home
              AnimatedArrow(
                direction: ArrowDirection.up,
                onTap: controller.goBack,
              ),

              const SizedBox(height: 12),

              const Text('Riwayat Deteksi', style: AppTextStyles.title),

              const SizedBox(height: 24),

              // Detection list
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.records.length,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DetectionCard(
                          record: controller.records[i],
                          onTap: () =>
                              controller.goToResult(controller.records[i]),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
