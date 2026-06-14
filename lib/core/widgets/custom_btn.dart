import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_text_theme.dart';

class CustomBtn extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool? isLoading;

  const CustomBtn({super.key, required this.title, this.onTap, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.0786,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: [
              isLoading ?? false ? AppColors.grey : AppColors.primary,
              isLoading ?? false ? AppColors.grey : AppColors.primaryDark,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(title, style: AppTextTheme.font16WhiteMedium),
        ),
      ),
    );
  }
}
