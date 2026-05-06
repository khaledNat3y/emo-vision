import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPinField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onCompleted;
  final ValueChanged<String>? onChanged;
  final int length;

  const OtpPinField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PinCodeTextField(
      appContext: context,
      autoDisposeControllers: false,
      length: length,
      controller: controller,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      cursorColor: AppColors.primary,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: true,
      onSubmitted: (value) {
        Logger.debug("OTP submitted: $value");
        if (onCompleted != null) onCompleted!();
      },
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 45,
        fieldWidth: 45,
        activeFillColor: theme.colorScheme.surface,
        inactiveFillColor: theme.colorScheme.surface,
        selectedFillColor: theme.colorScheme.surface,
        activeColor: AppColors.primary,
        inactiveColor: theme.colorScheme.outline,
        selectedColor: AppColors.primary,
        borderWidth: 2,
      ),
      onCompleted: (value) {
        if (onCompleted != null) onCompleted!();
      },
      onChanged: (value) {
        if (onChanged != null) onChanged!(value);
      },
    );
  }
}
