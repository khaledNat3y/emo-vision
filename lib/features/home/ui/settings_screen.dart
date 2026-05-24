import 'dart:ui';

import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  final String? userName;
  final String? email;
  final String? photoUrl;
  final VoidCallback? onLogout;

  const SettingsScreen({
    super.key,
    this.userName,
    this.email,
    this.photoUrl,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.headlineMedium?.color?.withValues(alpha: 0.9),
                fontSize: 24.sp,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            Text(
              "Configure your Intelligence and privacy and Preferences",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.regular,
                color: AppColors.grey.withValues(alpha: 0.9),
              ),
            ),
            verticalSpace(30.h),
            Text(
              "General Settings",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeightHelper.regular,
                color: AppColors.primary,
              ),
            ),

            /// LOGOUT BUTTON
            GestureDetector(
              onTap: onLogout,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
