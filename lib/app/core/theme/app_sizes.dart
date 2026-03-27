import 'package:get/get.dart';

/// Semua ukuran UI terpusat di sini.
/// Gunakan Get.width / Get.height agar otomatis responsif
/// tanpa perlu BuildContext di mana-mana.
///
/// Cara pakai:
///   SizedBox(height: AppSizes.spaceL)
///   Container(height: AppSizes.imageBoxHeight)
///   Container(width: AppSizes.iconBgMedium)  ← fixed, tidak perlu Get
abstract class AppSizes {
  static double get _w => Get.width;
  static double get _h => Get.height;

  // ── Spacing — skala dengan tinggi layar ─────────────────
  // Referensi: layar 832px (Pixel 6)
  static double get spaceXS  => _h * 0.010;  // ≈  8px
  static double get spaceS   => _h * 0.016;  // ≈ 13px
  static double get spaceM   => _h * 0.020;  // ≈ 17px
  static double get spaceL   => _h * 0.028;  // ≈ 23px
  static double get spaceXL  => _h * 0.035;  // ≈ 29px
  static double get spaceXXL => _h * 0.044;  // ≈ 37px

  // ── Horizontal padding — skala dengan lebar layar ───────
  // Referensi: layar 390px (iPhone 14)
  static double get paddingPage     => _w * 0.051;  // ≈ 20px
  static double get paddingPageWide => _w * 0.072;  // ≈ 28px

  // ── Elemen adaptif ───────────────────────────────────────
  static double get logoSize       => _w * 0.410;  // ≈ 160px
  static double get imageBoxHeight => _h * 0.330;  // ≈ 275px

  // ── Ukuran tetap (dp sudah device-independent, tidak perlu skala) ─
  static const double buttonHeight = 54;
  static const double iconBgSmall  = 36;   // HowItWorksRow
  static const double iconBgMedium = 48;   // DetectionCard
  static const double iconBgLarge  = 64;   // Tombol shutter / upload

  // ── Border radius ────────────────────────────────────────
  static const double radiusS    = 10;
  static const double radiusM    = 12;
  static const double radiusCard = 14;
  static const double radiusXL   = 20;
}
