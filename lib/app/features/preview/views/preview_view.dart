import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/image_preview_box.dart';
import '../../../core/widgets/prio_scan_button.dart';
import '../controllers/preview_controller.dart';

class PreviewView extends GetView<PreviewController> {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    'Preview Gambar',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title,
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => ImagePreviewBox(imagePath: controller.imagePath.value),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrioScanButton(
                      label: 'Ambil Ulang',
                      onTap: controller.retake,
                      color: AppColors.accentOrange,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrioScanButton(
                      label: 'SUBMIT',
                      onTap: controller.submit,
                      color: AppColors.buttonPurple,
                    ),
                  ),

                  const Spacer(),
                ],
              ),

              // Loading overlay
              Obx(
                () => controller.isLoading.value
                    ? Container(
                        color: Colors.black45,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
