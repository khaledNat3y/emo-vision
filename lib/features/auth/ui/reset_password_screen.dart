import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email_outlined, size: 80.sp, color: AppColors.primary),
              24.verticalSpace,
              Text(
                'Check Your Email',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              Text(
                'We\'ve sent a password reset link to your email address. Click the link in the email to reset your password.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              32.verticalSpace,
              CustomButton(
                text: 'Back to Login',
                onPressed: () {
                  context.pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    predicate: (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
