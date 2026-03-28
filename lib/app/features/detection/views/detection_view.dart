import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/image_preview_box.dart';
import '../../../core/widgets/prio_scan_button.dart';
import '../controllers/detection_controller.dart';

class DetectionView extends GetView<DetectionController> {
  const DetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGradientTop,
      appBar: AppBar(
        backgroundColor: AppColors.bgGradientTop,
        elevation: 0,
        leading: IconButton(
          onPressed: controller.goBack,
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: const Text('Deteksi Kendaraan', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: GradientBackground(
        child: SafeArea(
          top: false,
          // Stack memungkinkan overlay loading ditumpuk di atas konten
          child: Stack(
            children: [
              // Layer 1 — konten utama
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingPage),
                    child: Obx(() => _buildBox()),
                  ),

                  SizedBox(height: context.spaceXL),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingPage),
                    child: Obx(() => _buildButtons(context)),
                  ),
                ],
              ),

              // Layer 2 — overlay loading, hanya muncul saat isLoading = true
              Obx(() => controller.isLoading.value
                  ? Container(
                      color: Colors.black54,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox() {
    if (controller.isCaptured.value) {
      return ImagePreviewBox(imageData: controller.capturedImagePath.value);
    }
    if (controller.isCameraReady.value) {
      return _CameraBox(cameraController: controller.cameraController!);
    }
    return _LoadingBox();
  }

  Widget _buildButtons(BuildContext context) {
    if (controller.isCaptured.value) {
      return Column(
        children: [
          PrioScanButton(
            label: 'Ambil Ulang',
            onTap: controller.retake,
            color: AppColors.accentOrange,
          ),
          SizedBox(height: context.spaceS),
          PrioScanButton(
            label: 'SUBMIT',
            onTap: controller.submit,
            color: AppColors.buttonPurple,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: Icons.camera_alt_rounded,
          label: 'Ambil\nGambar',
          onTap: controller.capture,
        ),
        SizedBox(width: context.spaceXXL * 1.2),
        _ActionButton(
          icon: Icons.upload_rounded,
          label: 'Upload\nGambar',
          onTap: controller.pickFromGallery,
        ),
      ],
    );
  }
}

class _CameraBox extends StatelessWidget {
  final CameraController cameraController;

  const _CameraBox({required this.cameraController});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      child: SizedBox(
        width: double.infinity,
        height: context.imageBoxHeight,
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: cameraController.value.previewSize!.height,
            height: cameraController.value.previewSize!.width,
            child: CameraPreview(cameraController),
          ),
        ),
      ),
    );
  }
}

class _LoadingBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.imageBoxHeight,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        border: Border.all(color: Colors.white30, width: 1.5),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonPurple,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: AppSizes.iconBgLarge,
            height: AppSizes.iconBgLarge,
            decoration: BoxDecoration(
              color: AppColors.accentOrange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentOrange.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          SizedBox(height: context.spaceXS),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
