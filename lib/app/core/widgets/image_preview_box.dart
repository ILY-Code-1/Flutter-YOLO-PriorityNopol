import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ImagePreviewBox extends StatelessWidget {
  final String imagePath;

  const ImagePreviewBox({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white30, width: 1.5),
        ),
        child: imagePath.isNotEmpty
            ? Image.file(File(imagePath), fit: BoxFit.cover)
            : const SizedBox.shrink(),
      ),
    );
  }
}
