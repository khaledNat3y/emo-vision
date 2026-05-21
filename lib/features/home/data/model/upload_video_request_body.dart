import 'package:dio/dio.dart';

class UploadVideoRequestBody {
  final MultipartFile file;

  UploadVideoRequestBody({required this.file});

  factory UploadVideoRequestBody.fromJson(Map<String, dynamic> json) =>
      UploadVideoRequestBody(file: json['file']);

  Map<String, dynamic> toJson() => {'file': file};
}
