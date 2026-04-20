import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
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
    return PinCodeTextField(
      appContext: context,
      autoDisposeControllers: false,
      length: length,
      controller: controller,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      cursorColor: const Color(0xFF2F5FED),
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: true,
      onSubmitted: (value) {
        Logger.debug("OTP submitted: $value");
        if (onCompleted != null) onCompleted!();
      },
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 45,
        fieldWidth: 45,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeColor: const Color(0xFF2F5FED),
        inactiveColor: const Color(0xFFE8E8E8),
        selectedColor: const Color(0xFF2F5FED),
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
