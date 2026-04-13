import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String? photoUrl;
  final String? userName;
  final String? email;
  const HomeHeader({super.key, this.photoUrl, this.userName, this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'Emo',
            style: AppTextTheme.font20BoldPrimary.copyWith(
              color: AppColors.textPrimaryLight,
            ),
            children: [
              TextSpan(text: 'Vision', style: AppTextTheme.font20BoldPrimary),
            ],
          ),
        ),
        verticalSpace(20),

        ListTile(
          title: Text(
            "Welcome, ${userName ?? 'User'}",
            style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
          ),
          subtitle: Text(
            email ?? '',
            style: AppTextTheme.font13WhiteRegular.copyWith(
              color: AppColors.grey,
            ),
          ),
          trailing: Container(
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
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
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
        ),
      ],
    );
  }
}
