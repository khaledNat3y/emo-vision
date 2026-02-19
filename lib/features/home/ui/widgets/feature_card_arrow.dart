import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class FeatureCardArrow extends StatelessWidget {
  const FeatureCardArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: AppColors.grey.withValues(alpha: 0.5),
      size: 18,
    );
  }
}