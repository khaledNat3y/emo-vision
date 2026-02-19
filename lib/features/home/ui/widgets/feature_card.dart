import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';
import 'feature_card_icon.dart';
import 'feature_card_content.dart';
import 'feature_card_arrow.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.borderLight,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            FeatureCardIcon(icon: icon, color: color),
            const SizedBox(width: 16),
            FeatureCardContent(title: title, subtitle: subtitle),
            const FeatureCardArrow(),
          ],
        ),
      ),
    );
  }
}