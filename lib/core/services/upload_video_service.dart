import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/api_constant.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/upload_video_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'upload_video_service.g.dart';

@RestApi(baseUrl: ApiConstants.videoProcessingBaseUrl)
abstract class UploadVideoService {
  factory UploadVideoService(Dio dio, {String baseUrl}) = _UploadVideoService;

  @POST(ApiConstants.uploadVideo)
  @MultiPart()
  Future<UploadVideoResponseModel> uploadVideo(
    @Part(name: "file") MultipartFile file,
  );
}
