import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class EmailChip extends StatelessWidget {
  final String email;

  const EmailChip({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.email_outlined,
            size: 14,
            color: AppColors.white.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              email,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}