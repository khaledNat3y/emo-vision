import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_theme.dart';

class OrLoginWith extends StatelessWidget {
  const OrLoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1,
              color: AppColors.grey.withValues(alpha: 0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Or login with',
              style: AppTextTheme.font12GreyMedium.copyWith(
                color: AppColors.grey.withValues(alpha: 0.6),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: AppColors.grey.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
