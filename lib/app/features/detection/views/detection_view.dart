import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/image_preview_box.dart';
import '../../../core/widgets/kembali_button.dart';
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
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: KembaliButton(onTap: controller.goBack),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Deteksi Kendaraan',
                textAlign: TextAlign.center,
                style: AppTextStyles.title,
              ),

              const SizedBox(height: 24),

              // Image preview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ImagePreviewBox(
                    imagePath: controller.selectedImagePath.value,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Camera / Gallery buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PickerButton(
                    icon: Icons.camera_alt_rounded,
                    label: 'Ambil\nGambar',
                    onTap: controller.pickFromCamera,
                  ),
                  const SizedBox(width: 48),
                  _PickerButton(
                    icon: Icons.upload_rounded,
                    label: 'Upload\nGambar',
                    onTap: controller.pickFromGallery,
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerButton({
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
            width: 64,
            height: 64,
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
          const SizedBox(height: 8),
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
