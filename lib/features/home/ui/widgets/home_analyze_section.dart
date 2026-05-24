import 'dart:io';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/upload_video_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/analyze_button.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_result_card.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/video_upload_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAnalyzeSection extends StatefulWidget {
  final GlobalKey resultKey;

  const HomeAnalyzeSection({super.key, required this.resultKey});

  @override
  State<HomeAnalyzeSection> createState() => _HomeAnalyzeSectionState();
}

class _HomeAnalyzeSectionState extends State<HomeAnalyzeSection> {
  File? _selectedVideo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Section title
        // Text('Analyze Emotion', style: AppTextTheme.font20BoldPrimary),
        // SizedBox(height: 8.h),
        // Text(
        //   'Upload a video to detect facial emotions in real time.',
        //   style: Theme.of(context).textTheme.bodyMedium,
        // ),
        // SizedBox(height: 16.h),

        // Video picker
        VideoUploadSection(
          onVideoSelected: (file) {
            setState(() => _selectedVideo = file);
          },
        ),
        SizedBox(height: 24.h),

        BlocBuilder<UploadVideoCubit, UploadVideoState>(
          builder: (innerContext, uploadState) {
            final isLoading = uploadState is UploadVideoLoading;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Analyze button
                AnalyzeButton(
                  isLoading: isLoading,
                  onTap: (_selectedVideo != null && !isLoading)
                      ? () => innerContext.read<UploadVideoCubit>().uploadVideo(
                          _selectedVideo!,
                        )
                      : () {},
                ),

                // Result card
                if (uploadState is UploadVideoSuccess) ...[
                  SizedBox(height: 24.h),
                  SizedBox(
                    key: widget.resultKey,
                    child: HomeResultCard(data: uploadState.data),
                  ),
                ],
                verticalSpace(100),
              ],
            );
          },
        ),
      ],
    );
  }
}
