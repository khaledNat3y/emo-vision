import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: "League Spartan",
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      error: AppColors.error,
      onSurface: AppColors.textPrimaryLight,
      outline: AppColors.borderLight,
      outlineVariant: AppColors.dividerLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.surfaceLight,
    dividerColor: AppColors.dividerLight,
    iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),

    // Input Decoration Theme

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.bold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeightHelper.medium,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.borderLight),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryLight,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryLight,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.grey,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.grey,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textPrimaryLight,
      ),

      /// used in login screen form
      bodyMedium: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textTertiaryLight,
      ),
    ),
  );

  static ThemeData darkMode = ThemeData(
    fontFamily: "League Spartan",
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surfaceDark,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      error: AppColors.error,
      outline: AppColors.borderDark,
      outlineVariant: AppColors.dividerDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.surfaceDark,
    dividerColor: AppColors.dividerDark,
    iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),

    // Input Decoration Theme

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.bold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeightHelper.medium,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.borderDark),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryDark,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryDark,
      ),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryDark,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryDark,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimaryDark,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textSecondaryDark,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textTertiaryDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textSecondaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textTertiaryDark,
      ),
    ),
  );
}
