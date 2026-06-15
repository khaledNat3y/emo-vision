import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/thumbnail_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/upload_video_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;

class UploadVideoRepo {
  final UploadVideoService uploadVideoService;
  final SupabaseAuthService supabaseAuthService;
  final ThumbnailService thumbnailService;

  UploadVideoRepo(
    this.uploadVideoService,
    this.supabaseAuthService,
    this.thumbnailService,
  );

  Future<Either<UploadVideoResponseErrorModel, UploadVideoResponseModel>>
  uploadVideo(File file) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      );

      final response = await uploadVideoService.uploadVideo(multipartFile);

      await _saveToSupabase(file, response);

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

  Future<void> _saveToSupabase(
    File file,
    UploadVideoResponseModel response,
  ) async {
    try {
      final userId = supabaseAuthService.client.auth.currentUser?.id;
      if (userId == null) {
        Logger.error('Cannot save to Supabase: user not authenticated');
        return;
      }

      final videoName = file.path.split('/').last;

      // Generate and upload thumbnail
      final thumbnailUrl = await thumbnailService.generateAndUpload(
        videoPath: file.path,
        userId: userId,
        videoName: videoName,
      );

      final timelineJson = response.timelineData
          ?.map((e) => e.toJson())
          .toList();

      await supabaseAuthService.client.from('video_analyses').insert({
        'user_id': userId,
        'video_name': videoName,
        'status': response.prediction ?? 'Unknown',
        'engagement_score': response.overallScore?.toDouble(),
        'overall_confidence': _parseConfidence(response.overallConfidence),
        'thumbnail_url': thumbnailUrl, // now included
        'timeline_data': timelineJson,
        'created_at': DateTime.now().toIso8601String(),
      });

      Logger.debug('Video analysis saved to Supabase successfully');
    } catch (e) {
      Logger.error('Failed to save to Supabase: $e');
    }
  }

  double? _parseConfidence(String? confidence) {
    if (confidence == null) return null;
    final cleaned = confidence.replaceAll('%', '').trim();
    final parsed = double.tryParse(cleaned);
    return parsed != null ? parsed / 100 : null;
  }
}
