import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String? photoUrl;
  const HomeHeader({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Boredom App',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Let\'s have some fun! 🎬',
              style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
            ),
          ],
        ),
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: photoUrl != null && photoUrl!.isNotEmpty
                ? Image.network(
                    photoUrl!,
                    fit: BoxFit.cover,
                    width: 50.w,
                    height: 50.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                        size: 28.w,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                        ),
                      );
                    },
                  )
                : Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                    size: 28.w,
                  ),
          ),
        ),
      ],
    );
  }
}
