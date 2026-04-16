import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final FocusNode? focusNode;
  final bool? isReadOnly;
  final String? initialValue;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.isObscureText,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.focusNode,
    this.isReadOnly,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscureText ?? false,
      cursorColor: AppColors.primary,
      readOnly: isReadOnly ?? false,
      decoration: InputDecoration(
        fillColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
        filled: true,
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.5.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.3,
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        hintFadeDuration: const Duration(milliseconds: 500),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.error),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.3,
                color: AppColors.borderLight,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.error),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: hintText,
        hintStyle:
            hintStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey.withValues(alpha: 0.8),
            ),
        suffixIcon: suffixIcon,
      ),
      // style: AppTheme.font14DarkBlueMedium,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
