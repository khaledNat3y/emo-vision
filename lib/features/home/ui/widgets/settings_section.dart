import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsSection extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Color? titleColor;
  final Function()? onTap;
  const SettingsSection({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.grey.withValues(alpha: 0.1),
      child: ListTile(
        leading: leading,
        title: Text(
          title ?? "Account",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.regular,
            color: titleColor ?? Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        trailing: trailing,
      ),
    );
  }
}
