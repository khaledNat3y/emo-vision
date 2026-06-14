// lib/features/auth/ui/email_verified_screen.dart

import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({super.key});

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
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_outlined,
                  size: 56.sp,
                  color: AppColors.primary,
                ),
              ),
              32.verticalSpace,
              Text(
                'Email Verified!',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              Text(
                'Your email has been verified successfully. You can now log in to your account.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              CustomButton(
                text: 'Go to Login',
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
