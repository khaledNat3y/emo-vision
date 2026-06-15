import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/history_cubit/cubit/history_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/history_video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'History',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            Text(
              'Your recent video analyses',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey.withValues(alpha: 0.9),
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                    success: (videos) => videos.isEmpty
                        ? _EmptyHistory()
                        : RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () =>
                                context.read<HistoryCubit>().fetchHistory(),
                            child: ListView.builder(
                              itemCount: videos.length,
                              itemBuilder: (context, index) =>
                                  HistoryVideoCard(video: videos[index]),
                            ),
                          ),
                    error: (message) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.sp,
                            color: AppColors.error,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.grey),
                          ),
                          SizedBox(height: 16.h),
                          TextButton(
                            onPressed: () =>
                                context.read<HistoryCubit>().fetchHistory(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 72.sp,
            color: AppColors.grey.withValues(alpha: 0.4),
          ),
          SizedBox(height: 16.h),
          Text(
            'No videos yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Upload a video from the home screen\nto see your analysis history here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.grey.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
