import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeResultCard extends StatelessWidget {
  final UploadVideoResponseModel data;

  const HomeResultCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final prediction = data.prediction ?? 'Unknown';
    final totalFrames = data.metadata?.totalFrames ?? 0;

    // Determine engaged/not-engaged from prediction string
    final isEngaged =
        prediction.toLowerCase() == 'engaged' ||
        prediction.toLowerCase() == '1';

    final resultColor = isEngaged ? Colors.green.shade600 : AppColors.error;
    final resultIcon = isEngaged
        ? Icons.sentiment_satisfied_rounded
        : Icons.sentiment_dissatisfied_rounded;
    final resultLabel = isEngaged ? 'Engaged' : 'Not Engaged';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: resultColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: resultColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Row(
            children: [
              Icon(
                Icons.analytics_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Analysis Result',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //Result badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: resultColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(resultIcon, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  resultLabel,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Prediction raw value
          _InfoRow(label: 'Prediction:', value: prediction, color: resultColor),

          // Total frames
          if (totalFrames > 0) ...[
            SizedBox(height: 6.h),
            _InfoRow(
              label: 'Frames analyzed:',
              value: '$totalFrames frames',
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
