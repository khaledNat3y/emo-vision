import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_response.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/otp_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/verify_email_request_body.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/register_request_body.dart';
import '../../features/auth/data/models/register_response.dart';
import '../networking/api_constant.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(ApiConstants.login)
  Future<LoginResponse> loginUser({@Body() required LoginRequestBody body});
  @POST(ApiConstants.register)
  Future<RegisterResponse> register({@Body() required RegisterRequestBody body});
  @POST(ApiConstants.verifyEmail)
  Future<dynamic> verifyEmail({@Body() required VerifyEmailRequestBody body});
}