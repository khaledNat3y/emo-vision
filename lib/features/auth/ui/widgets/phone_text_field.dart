import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/theming/app_colors.dart';

class PhoneTextField extends StatelessWidget {
  final void Function(PhoneNumber)? onChanged;
  const PhoneTextField({
    super.key, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        isDense: true,
        contentPadding:
        EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.5.h),
        focusedBorder:OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.primary),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintFadeDuration: const Duration(milliseconds: 500),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.error),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder:OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: AppColors.error),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: "000 000 0000",
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black),
      ),
      initialCountryCode: 'EG',
      onChanged: (phone) {
        onChanged!(phone);
      },
    );
  }
}
