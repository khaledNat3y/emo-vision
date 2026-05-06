import 'dart:io';

import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/repo/upload_video_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_video_state.dart';

class UploadVideoCubit extends Cubit<UploadVideoState> {
  UploadVideoRepo uploadVideoRepo;
  UploadVideoCubit(this.uploadVideoRepo) : super(UploadVideoInitial());

  Future<void> uploadVideo(File file) async {
    emit(UploadVideoLoading());

    final result = await uploadVideoRepo.uploadVideo(file);

    result.fold(
      (error) => emit(UploadVideoError(error: error)),
      (data) => emit(UploadVideoSuccess(data: data)),
    );
  }
}
