import 'package:flutter/material.dart';

/// Konstanta ukuran tetap (device-independent, tidak perlu context).
abstract class AppSizes {
  static const double buttonHeight = 54;
  static const double iconBgSmall  = 36;
  static const double iconBgMedium = 48;
  static const double iconBgLarge  = 64;

  static const double radiusS    = 10;
  static const double radiusM    = 12;
  static const double radiusCard = 14;
  static const double radiusXL   = 20;
}

/// Ukuran responsif — gunakan di dalam build() method via `context.spaceL` dll.
///
/// Menggunakan MediaQuery.sizeOf(context) alih-alih Get.width/Get.height
/// agar nilai selalu tepat sejak frame pertama (Get.width bisa return 0.0
/// sebelum layout pass pertama selesai, menyebabkan layout berantakan).
extension AppSizesContext on BuildContext {
  double get _w => MediaQuery.sizeOf(this).width;
  double get _h => MediaQuery.sizeOf(this).height;

  // ── Spacing — skala dengan tinggi layar ─────────────────
  // Referensi: layar 832px (Pixel 6)
  double get spaceXS  => _h * 0.010;  // ≈  8px
  double get spaceS   => _h * 0.016;  // ≈ 13px
  double get spaceM   => _h * 0.020;  // ≈ 17px
  double get spaceL   => _h * 0.028;  // ≈ 23px
  double get spaceXL  => _h * 0.035;  // ≈ 29px
  double get spaceXXL => _h * 0.044;  // ≈ 37px

  // ── Horizontal padding — skala dengan lebar layar ───────
  // Referensi: layar 390px (iPhone 14)
  double get paddingPage     => _w * 0.051;  // ≈ 20px
  double get paddingPageWide => _w * 0.072;  // ≈ 28px

  // ── Elemen adaptif ───────────────────────────────────────
  double get logoSize       => _w * 0.410;  // ≈ 160px
  double get imageBoxHeight => _h * 0.330;  // ≈ 275px
}
