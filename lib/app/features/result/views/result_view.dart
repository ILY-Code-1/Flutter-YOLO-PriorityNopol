import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_sizes.dart';
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
    final path = 'assets/images/ambulance.webp';
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.paddingPage,
                  context.spaceM,
                  context.paddingPage,
                  0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: KembaliButton(onTap: controller.goToHistory),
                ),
              ),

              SizedBox(height: context.spaceS),

              const Text(
                'Hasil Deteksi',
                textAlign: TextAlign.center,
                style: AppTextStyles.title,
              ),

              SizedBox(height: context.spaceL),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.paddingPage),
                child: Obx(
                  () => ImagePreviewBox(
                    imagePath: controller.record.value?.imagePath ?? path,
                  ),
                ),
              ),

              SizedBox(height: context.spaceL),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.paddingPage),
                child: Obx(() {
                  final r = controller.record.value;
                  if (r == null) return const SizedBox.shrink();
                  return Column(
                    children: [
                      InfoField(
                        label: 'Jenis Kendaraan:',
                        value: r.vehicleType,
                      ),
                      SizedBox(height: context.spaceL),
                      InfoField(label: 'Nomor Polisi:', value: r.plateNumber),
                      SizedBox(height: context.spaceL),
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
