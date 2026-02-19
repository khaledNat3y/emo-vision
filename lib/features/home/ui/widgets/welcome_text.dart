import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class WelcomeText extends StatelessWidget {
  final String userName;

  const WelcomeText({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 28,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}