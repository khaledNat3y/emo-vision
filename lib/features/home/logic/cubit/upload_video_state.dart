part of 'upload_video_cubit.dart';

@immutable
sealed class UploadVideoState {}

final class UploadVideoInitial extends UploadVideoState {}

final class UploadVideoLoading extends UploadVideoState {}

final class UploadVideoSuccess extends UploadVideoState {
  final UploadVideoResponseModel data;

  UploadVideoSuccess({required this.data});
}

final class UploadVideoError extends UploadVideoState {
  final UploadVideoResponseErrorModel error;

  UploadVideoError({required this.error});
}
