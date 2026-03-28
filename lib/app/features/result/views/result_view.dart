import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
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
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header — back button (tidak ikut scroll) ─────────────
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

              SizedBox(height: context.spaceM),

              // ── Konten yang bisa di-scroll ───────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.paddingPage,
                  ),
                  child: Obx(() {
                    final r = controller.record.value;
                    if (r == null) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ImagePreviewBox(imageData: r.imageData),

                        SizedBox(height: context.spaceM),

                        InfoField(
                          label: 'Jenis Kendaraan:',
                          value: r.vehicleType,
                        ),
                        SizedBox(height: context.spaceM),
                        InfoField(label: 'Nomor Polisi:', value: r.plateNumber),
                        SizedBox(height: context.spaceM),
                        // ── Confidence badge ─────────────────────────
                        _ConfidenceBadge(confidence: r.confidence),
                        SizedBox(height: context.spaceM),
                        InfoField(
                          label: 'Tanggal Deteksi:',
                          value: r.formattedDate,
                        ),
                        SizedBox(height: context.spaceL),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Confidence badge widget ──────────────────────────────────────────────────
class _ConfidenceBadge extends StatelessWidget {
  final double confidence;

  const _ConfidenceBadge({required this.confidence});

  // confidence adalah nilai 0.0–1.0
  String get _label {
    if (confidence > 0.80) return 'High';
    if (confidence > 0.60) return 'Medium';
    return 'Low';
  }

  Color get _color {
    if (confidence > 0.80) return const Color(0xFF4CAF50); // hijau
    if (confidence > 0.60) return const Color(0xFFFF9800); // orange
    return const Color(0xFFF44336); // merah
  }

  String get _percentage => '${(confidence * 100).toStringAsFixed(1)}%';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label di luar container — sama persis seperti InfoField
        const Text('Confidence:', style: AppTextStyles.fieldLabel),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.fieldPurple,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: Row(
            children: [
              // Persentase di kiri
              Text(
                _percentage,
                style: TextStyle(
                  color: _color,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const Spacer(),

              // Pill badge (High / Medium / Low) di kanan
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _color, width: 1.2),
                ),
                child: Text(
                  _label,
                  style: TextStyle(
                    color: _color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
