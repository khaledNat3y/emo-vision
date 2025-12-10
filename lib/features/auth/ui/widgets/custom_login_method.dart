import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_theme.dart';

class CustomLoginMethod extends StatelessWidget {
  final String iconPath;
  final String title;
  final void Function()? onTap;
  const CustomLoginMethod({super.key, required this.iconPath, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.416,
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 14.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            10.horizontalSpace,
            Text(
              title,
              style: AppTextTheme.font14BlackSemiBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
