import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class KembaliButton extends StatelessWidget {
  final VoidCallback onTap;

  const KembaliButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 22),
          Text('Kembali', style: AppTextStyles.backButton),
        ],
      ),
    );
  }
}
