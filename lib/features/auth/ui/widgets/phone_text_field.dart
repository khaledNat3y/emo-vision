import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/theming/app_colors.dart';

class PhoneTextField extends StatelessWidget {
  final void Function(PhoneNumber)? onChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final TextEditingController controller;

  const PhoneTextField({
    super.key,
    this.onChanged,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      validator: validator ?? _defaultEgyptianValidator,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        isDense: true,
        contentPadding:
        EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.5.h),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.primary),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintFadeDuration: const Duration(milliseconds: 500),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.error),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.error),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: "000 000 0000",
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.black),
      ),
      initialCountryCode: 'EG',
      onChanged: (phone) {
        if (onChanged != null) {
          onChanged!(phone);
        }
      },
    );
  }

  /// Default validator for Egyptian phone numbers
  String? _defaultEgyptianValidator(PhoneNumber? phone) {
    // Check if phone is null or empty
    if (phone == null || phone.number.isEmpty) {
      return 'Phone number is required';
    }

    // Get the phone number without country code
    String phoneNumber = phone.number;

    // Remove any spaces, dashes, or special characters
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Check if it's an Egyptian number
    if (phone.countryCode != '20') {
      return 'Please select Egypt (+20)';
    }

    // Egyptian mobile numbers are 10 digits (without country code)
    if (phoneNumber.length != 10) {
      return 'Phone number must be 10 digits';
    }

    // Valid Egyptian mobile prefixes
    // 010 - Vodafone
    // 011 - Etisalat
    // 012 - Orange
    // 015 - WE (We Telecom Egypt)
    final List<String> validPrefixes = ['010', '011', '012', '015'];

    // Check if the number starts with a valid prefix
    final bool hasValidPrefix = validPrefixes.any((prefix) => phoneNumber.startsWith(prefix));

    if (!hasValidPrefix) {
      return 'Must start with 010, 011, 012, or 015';
    }

    return null; // Valid
  }
}