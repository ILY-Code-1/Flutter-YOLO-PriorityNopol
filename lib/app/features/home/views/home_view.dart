import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/animated_arrow.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/how_it_works_row.dart';
import '../../../core/widgets/prio_scan_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 36),

                      // Title
                      const Text(
                        'Priority Vehicle\nDetection',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headline,
                      ),

                      const SizedBox(height: 24),

                      // Illustration circle
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 20,
                              color: Colors.black26,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.directions_car_rounded,
                          size: 72,
                          color: AppColors.bgGradientTop,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Description
                      const SizedBox(
                        width: 280,
                        child: Text(
                          'Aplikasi untuk mendeteksi ambulans, pemadam kebakaran, dan kendaraan kepolisian menggunakan YOLO V8 — lalu membaca nomor polisinya secara otomatis',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Section divider
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Colors.white30)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: const Text(
                              'CARA KERJA',
                              style: AppTextStyles.sectionLabel,
                            ),
                          ),
                          const Expanded(child: Divider(color: Colors.white30)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // How it works rows
                      const HowItWorksRow(
                        icon: Icons.camera_alt_outlined,
                        text: 'Upload atau ambil gambar kendaraan',
                      ),
                      const SizedBox(height: 14),
                      const HowItWorksRow(
                        icon: Icons.document_scanner_outlined,
                        text:
                            'Sistem EasyOCR membaca area plat nomor secara otomatis',
                      ),
                      const SizedBox(height: 14),
                      const HowItWorksRow(
                        icon: Icons.memory_outlined,
                        text:
                            'Setiap deteksi disimpan dan melatih sistem yang lebih pintar',
                      ),

                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),

              // Bottom CTA section — always visible
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                child: Column(
                  children: [
                    PrioScanButton(
                      label: 'GET STARTED',
                      onTap: controller.goToDetection,
                      color: AppColors.buttonPurple,
                    ),
                    const SizedBox(height: 20),
                    AnimatedArrow(
                      direction: ArrowDirection.down,
                      onTap: controller.goToHistory,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
