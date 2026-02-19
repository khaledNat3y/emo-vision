import 'package:flutter/material.dart';

class FeatureCardIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const FeatureCardIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: color,
        size: 28,
      ),
    );
  }
}