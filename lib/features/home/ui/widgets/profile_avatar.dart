import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String userName;

  const ProfileAvatar({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withOpacity(0.2),
        border: Border.all(
          color: AppColors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          userName.isNotEmpty ? userName[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 24,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}