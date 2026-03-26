import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textWhite,
    letterSpacing: -0.5,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: -0.3,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textWhite,
    height: 1.6,
  );

  static const TextStyle sectionLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.white54,
    letterSpacing: 2.0,
  );

  static const TextStyle vehicleName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle plateNumber = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textOrange,
    letterSpacing: 1.2,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  static const TextStyle fieldValue = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: 1.0,
  );

  static const TextStyle backButton = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
  );
}
