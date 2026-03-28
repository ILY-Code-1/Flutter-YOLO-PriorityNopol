import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
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
          SizedBox(height: context.spaceM),

          AnimatedArrow(
            direction: ArrowDirection.up,
            onTap: controller.goToHome,
          ),

          SizedBox(height: context.spaceS),

          const Text('Riwayat Deteksi', style: AppTextStyles.title),

          SizedBox(height: context.spaceS),

          // ── Filter dropdown — di bawah title ────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingPage),
            child: Obx(
              () => _CategoryDropdown(
                value: controller.selectedCategory.value,
                categories: MainController.categories,
                onChanged: controller.setCategory,
              ),
            ),
          ),

          SizedBox(height: context.spaceS),

          Expanded(
            child: Obx(
              () {
                final list = controller.filteredRecords;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada data untuk kategori ini',
                      style: AppTextStyles.body.copyWith(color: Colors.white54),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: context.paddingPage),
                  itemCount: list.length,
                  itemBuilder: (_, i) => Padding(
                    padding: EdgeInsets.only(bottom: context.spaceS),
                    child: DetectionCard(
                      record: list[i],
                      onTap: () => controller.goToResult(list[i]),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: context.spaceL),
        ],
      ),
    );
  }
}

// ── Widget dropdown kategori ─────────────────────────────────────────────────
class _CategoryDropdown extends StatelessWidget {
  final String value;
  final List<String> categories;
  final ValueChanged<String?> onChanged;

  const _CategoryDropdown({
    required this.value,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.bgGradientTop,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.white70),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          items: categories
              .map(
                (cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
