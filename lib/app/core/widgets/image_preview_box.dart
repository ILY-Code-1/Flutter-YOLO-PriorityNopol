import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class ImagePreviewBox extends StatelessWidget {
  final String imageData;

  const ImagePreviewBox({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      child: Container(
        width: double.infinity,
        height: context.imageBoxHeight,
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(color: Colors.white30, width: 1.5),
        ),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imageData.isEmpty) return const SizedBox.shrink();
    if (imageData.startsWith('assets/')) {
      return Image.asset(imageData, fit: BoxFit.cover);
    }
    // Local file path (preview before submit) — starts with '/' on Android/iOS
    if (imageData.startsWith('/')) {
      return Image.file(File(imageData), fit: BoxFit.cover);
    }
    // Strip data URI prefix: "data:image/...;base64,{data}"
    final base64Str = imageData.contains(',')
        ? imageData.split(',').last
        : imageData;
    return Image.memory(base64Decode(base64Str), fit: BoxFit.cover);
  }
}
