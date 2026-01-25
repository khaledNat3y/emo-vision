import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? isLoading;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading == true,  // Prevents clicking while loading
      child: InkWell(
        onTap: isLoading ?? false ? null : onPressed,
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.0786,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [
                isLoading ?? false ? AppColors.grey : AppColors.primary,
                isLoading ?? false ? AppColors.grey : AppColors.primaryDark
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(child: Text(isLoading ?? false ? 'Loading...' : text, style: AppTextTheme.font16WhiteMedium,)),
        ),
      ),
    );
  }
}

