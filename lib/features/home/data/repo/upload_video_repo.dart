import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_client.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/upload_video_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_model.dart';

class UploadVideoRepo {
  final UploadVideoService uploadVideoService;

  UploadVideoRepo(this.uploadVideoService);

  Future<Either<UploadVideoResponseErrorModel, UploadVideoResponseModel>>
  uploadVideo(File file) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      );

      final response = await uploadVideoService.uploadVideo(multipartFile);

      return Right(response);
    } on DioException catch (e) {
      Logger.error(e.toString());
      final error = UploadVideoResponseErrorModel.fromJson(
        e.response?.data ?? {},
      );
      return Left(error);
    } catch (e) {
      Logger.error(e.toString());

      return Left(
        UploadVideoResponseErrorModel(detail: [Detail(msg: e.toString())]),
      );
    }
  }
}
