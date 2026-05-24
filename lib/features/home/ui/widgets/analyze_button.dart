import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';

class AnalyzeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const AnalyzeButton({
    super.key,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLoading
                    ? [AppColors.grey, AppColors.grey]
                    : [AppColors.primary, AppColors.tertiary],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: isLoading
                  ? []
                  : [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(76),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onTap,
                borderRadius: BorderRadius.circular(16.r),
                child: Center(
                  child: isLoading
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Stay patient, something cool is loading…',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeightHelper.medium,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_circle_filled_rounded,
                              color: AppColors.white,
                              size: 24.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Analyze Video',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
