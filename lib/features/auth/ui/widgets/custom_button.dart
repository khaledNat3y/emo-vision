import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? isLoading;
  final double? radius;
  final Color? color;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading,
    this.radius,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      // Prevents clicking while loading
      ignoring: isLoading == true,
      child: InkWell(
        onTap: isLoading ?? false ? null : onPressed,
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.0786,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 50),
            gradient: LinearGradient(
              colors: [
                isLoading ?? false
                    ? AppColors.grey
                    : color ?? AppColors.primary,
                isLoading ?? false
                    ? AppColors.grey
                    : color ?? AppColors.primaryDark,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Text(
              isLoading ?? false ? 'Loading...' : text,
              style: textStyle ?? AppTextTheme.font16WhiteMedium,
            ),
          ),
        ),
      ),
    );
  }
}
