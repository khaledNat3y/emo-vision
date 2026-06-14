import 'dart:io';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/upload_video_cubit/upload_video_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/analyze_button.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_result_card.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/video_upload_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAnalyzeSection extends StatefulWidget {
  const HomeAnalyzeSection({super.key});

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
                  SizedBox(child: HomeResultCard(data: uploadState.data)),
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
