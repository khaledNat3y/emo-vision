import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/video_analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HistoryVideoCard extends StatelessWidget {
  final VideoAnalysis video;

  const HistoryVideoCard({super.key, required this.video});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'engaged':
        return AppColors.success;
      case 'not engaged':
        return AppColors.error;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _statusColor(video.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: video.thumbnailUrl != null
                ? Image.network(
                    video.thumbnailUrl!,
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholderThumbnail(),
                  )
                : _placeholderThumbnail(),
          ),

          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video name + status badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        video.videoName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeightHelper.semiBold,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        video.status,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeightHelper.medium,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Upload date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 13.sp,
                      color: AppColors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      DateFormat(
                        'MMM d, yyyy • h:mm a',
                      ).format(video.createdAt),
                      style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // Scores row
                Row(
                  children: [
                    Expanded(
                      child: _ScoreTile(
                        label: 'Engagement',
                        value: video.engagementScore,
                        icon: Icons.emoji_emotions_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _ScoreTile(
                        label: 'Confidence',
                        value: video.overallConfidence,
                        icon: Icons.bar_chart_rounded,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderThumbnail() {
    return Container(
      height: 160.h,
      width: double.infinity,
      color: AppColors.grey.withValues(alpha: 0.1),
      child: Icon(
        Icons.video_file_outlined,
        size: 48,
        color: AppColors.grey.withValues(alpha: 0.4),
      ),
    );
  }
}

class _ScoreTile extends StatelessWidget {
  final String label;
  final double? value;
  final IconData icon;
  final Color color;

  const _ScoreTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: color),
          SizedBox(width: 6.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 10.sp, color: AppColors.grey),
              ),
              Text(
                value != null ? '${(value! * 100).toStringAsFixed(1)}%' : 'N/A',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
