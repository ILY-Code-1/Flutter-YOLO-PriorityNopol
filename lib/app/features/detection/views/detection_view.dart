import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/image_preview_box.dart';
import '../../../core/widgets/kembali_button.dart';
import '../../../core/widgets/prio_scan_button.dart';
import '../controllers/detection_controller.dart';

class DetectionView extends GetView<DetectionController> {
  const DetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    AppSizes.paddingPage, AppSizes.spaceM, AppSizes.paddingPage, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: KembaliButton(onTap: controller.goBack),
                ),
              ),

              SizedBox(height: AppSizes.spaceS),

              const Text(
                'Deteksi Kendaraan',
                textAlign: TextAlign.center,
                style: AppTextStyles.title,
              ),

              SizedBox(height: AppSizes.spaceL),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingPage),
                child: Obx(() => _buildBox()),
              ),

              SizedBox(height: AppSizes.spaceXL),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingPage),
                child: Obx(() => _buildButtons()),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox() {
    if (controller.isCaptured.value) {
      return ImagePreviewBox(imagePath: controller.capturedImagePath.value);
    }
    if (controller.isCameraReady.value) {
      return _CameraBox(cameraController: controller.cameraController!);
    }
    return _LoadingBox();
  }

  Widget _buildButtons() {
    if (controller.isCaptured.value) {
      return Column(
        children: [
          PrioScanButton(
            label: 'Ambil Ulang',
            onTap: controller.retake,
            color: AppColors.accentOrange,
          ),
          SizedBox(height: AppSizes.spaceS),
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
        SizedBox(width: AppSizes.spaceXXL * 1.2),
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
        height: AppSizes.imageBoxHeight,
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
      height: AppSizes.imageBoxHeight,
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
          SizedBox(height: AppSizes.spaceXS),
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
