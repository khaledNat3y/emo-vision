import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';
import 'profile_avatar.dart';
import 'email_chip.dart';
import 'welcome_text.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String email;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeText(userName: userName),
              ProfileAvatar(userName: userName),
            ],
          ),
          const SizedBox(height: 16),
          EmailChip(email: email),
        ],
      ),
    );
  }
}