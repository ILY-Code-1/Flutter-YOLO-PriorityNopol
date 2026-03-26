import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class PrioScanButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const PrioScanButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: Text(label, style: AppTextStyles.buttonText),
          ),
        ),
      ),
    );
  }
}
