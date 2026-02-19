import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/signout_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleSignOut(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.error.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_outlined,
              color: AppColors.error,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (context) => const SignOutDialog(),
    );

    if (shouldSignOut == true && context.mounted) {
      // Perform sign out
      // Navigator.pushReplacementNamed(context, '/login');
      // Or navigate to welcome screen as needed
    }
  }
}