import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/spacing.dart';
import '../theming/app_colors.dart';

class PasswordValidation extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;

  const PasswordValidation(
      {super.key,
      required this.hasLowerCase,
      required this.hasUpperCase,
      required this.hasSpecialCharacters,
      required this.hasNumber,
      required this.hasMinLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow('At least 1 lowercase letter', hasLowerCase, context),
        2.verticalSpace,
        buildValidationRow('At least 1 uppercase letter', hasUpperCase, context),
        2.verticalSpace,
        buildValidationRow('At least 1 special characters', hasSpecialCharacters, context),
        2.verticalSpace,
        buildValidationRow('At least 1 number', hasNumber, context),
        2.verticalSpace,
        buildValidationRow('At least 8 characters long', hasMinLength, context),
        2.verticalSpace,

      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated, context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 2.5,
          backgroundColor: hasValidated ? AppColors.primary : AppColors.grey.withAlpha(80),
        ),
        horizontalSpace(6),
        Row(
          children: [
            Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(
            //   decoration: hasValidated ? TextDecoration.lineThrough : null,
            // decorationColor: AppColors.black,
            decorationThickness: 2,
            color: hasValidated ? AppColors.primary : AppColors.primary.withAlpha(90)),),
            2.horizontalSpace,
            Icon(hasValidated ? Icons.check : null, color: hasValidated ? AppColors.primary : AppColors.primary.withAlpha(90), size: 16.sp,)
          ],
        )
      ],
    );
  }
}
