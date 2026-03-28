import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/animated_arrow.dart';
import '../../../core/widgets/how_it_works_row.dart';
import '../../../core/widgets/prio_scan_button.dart';
import '../controllers/main_controller.dart';

class HomePage extends StatelessWidget {
  final MainController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.paddingPageWide,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.spaceXXL),

                  const Text(
                    'Priority Vehicle\nDetection',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline,
                  ),

                  SizedBox(height: context.spaceL),

                  // Ilustrasi logo
                  Container(
                    width: context.logoSize,
                    height: context.logoSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black26,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: context.spaceXL),

                  SizedBox(
                    width: context.logoSize * 2,
                    child: const Text(
                      'Aplikasi untuk mendeteksi ambulans, pemadam kebakaran, dan kendaraan kepolisian menggunakan YOLO V8 — lalu membaca nomor polisinya secara otomatis',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ),

                  SizedBox(height: context.spaceL),

                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white30)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'CARA KERJA',
                          style: AppTextStyles.sectionLabel,
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white30)),
                    ],
                  ),

                  SizedBox(height: context.spaceL),

                  const HowItWorksRow(
                    icon: Icons.camera_alt_outlined,
                    text: 'Upload atau ambil gambar kendaraan',
                  ),
                  SizedBox(height: context.spaceS),
                  const HowItWorksRow(
                    icon: Icons.document_scanner_outlined,
                    text:
                        'Sistem EasyOCR membaca area plat nomor secara otomatis',
                  ),
                  SizedBox(height: context.spaceS),
                  const HowItWorksRow(
                    icon: Icons.memory_outlined,
                    text:
                        'Setiap deteksi disimpan dan melatih sistem yang lebih pintar',
                  ),

                  SizedBox(height: context.spaceXXL),
                ],
              ),
            ),
          ),

          // Tombol & arrow — selalu di bawah layar
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.paddingPageWide,
              0,
              context.paddingPage,
              context.spaceS,
            ),
            child: Column(
              children: [
                PrioScanButton(
                  label: 'GET STARTED',
                  onTap: controller.goToDetection,
                  color: AppColors.buttonPurple,
                ),
                SizedBox(height: context.spaceL),
                AnimatedArrow(
                  direction: ArrowDirection.down,
                  onTap: controller.goToHistory,
                ),
                SizedBox(height: context.spaceM),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
