import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/video_upload_widget.dart';

class VideoUploadSection extends StatelessWidget {
  final Function(File?) onVideoSelected;

  const VideoUploadSection({super.key, required this.onVideoSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Your Video',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Select a video from your gallery to get started',
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 20.h),
        VideoUploadWidget(onVideoSelected: onVideoSelected),
      ],
    );
  }
}
