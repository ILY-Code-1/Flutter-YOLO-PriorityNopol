import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/image_preview_box.dart';
import '../../../core/widgets/info_field.dart';
import '../../../core/widgets/kembali_button.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

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
                  child: KembaliButton(onTap: controller.goToHistory),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Hasil Deteksi',
                textAlign: TextAlign.center,
                style: AppTextStyles.title,
              ),

              const SizedBox(height: 20),

              // Image preview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ImagePreviewBox(
                    imagePath: controller.record.value?.imagePath ?? '',
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Info fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  final r = controller.record.value;
                  if (r == null) return const SizedBox.shrink();
                  return Column(
                    children: [
                      InfoField(
                        label: 'Jenis Kendaraan:',
                        value: r.vehicleType,
                      ),
                      const SizedBox(height: 16),
                      InfoField(
                        label: 'Nomor Polisi:',
                        value: r.plateNumber,
                      ),
                      const SizedBox(height: 16),
                      InfoField(
                        label: 'Tanggal Dibuat',
                        value: r.formattedDate,
                      ),
                    ],
                  );
                }),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
