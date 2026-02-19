import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/api_result.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/firebase_services.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_response.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/verify_email_request_body.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constant/cache_constants.dart';
import '../../../../core/helpers/logger.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../models/otp_error_model.dart';
import '../models/register_request_body.dart';
import '../models/register_response.dart';

class AuthRepo {
  final AuthService authService;
  final FirebaseServices firebaseServices;

  AuthRepo(this.authService, this.firebaseServices);

  Future<ApiResult<LoginResponse>> login({
    required LoginRequestBody body,
  }) async {
    try {
      final response = await authService.loginUser(body: body);
      await SharedPrefHelper.setSecuredString(
        CacheConstants.accessToken,
        response.accessToken,
      );
      await SharedPrefHelper.setSecuredString(
        CacheConstants.refreshToken,
        response.refreshToken,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequestBody body,
  }) async {
    try {
      final response = await authService.register(body: body);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<Either<OtpErrorModel, String>> verifyEmail({
    required VerifyEmailRequestBody body,
  }) async {
    try {
      final response = await authService.verifyEmail(body: body);
      return Right(response);
    } catch (e) {
      Logger.error('OTP Error: ${e.toString()}');

      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          try {
            final errorData = e.response!.data;

            Logger.error('Error Data Type: ${errorData.runtimeType}');
            Logger.error('Error Data: $errorData');

            // Dio automatically parses JSON, so errorData is already a Map
            if (errorData is Map<String, dynamic>) {
              final errorModel = OtpErrorModel.fromJson(errorData);
              Logger.error('Parsed OTP Error Model - Message: ${errorModel.message}');
              Logger.error('Parsed OTP Error Model - Errors: ${errorModel.errors.otp}');
              return Left(errorModel);
            } else if (errorData is String) {
              // Handle case where response is a plain string
              Logger.error('Error data is String: $errorData');
              return Left(
                OtpErrorModel(
                  statusCode: e.response?.statusCode ?? 400,
                  message: errorData,
                  errors: Errors(otp: [errorData]),
                ),
              );
            } else {
              // Unknown format
              Logger.error('Unknown error format');
              return Left(
                OtpErrorModel(
                  statusCode: e.response?.statusCode ?? 400,
                  message: 'An error occurred during verification',
                  errors: Errors(otp: ['Verification failed. Please try again.']),
                ),
              );
            }
          } catch (parseError) {
            Logger.error('Error parsing OTP error: ${parseError.toString()}');
            return Left(
              OtpErrorModel(
                statusCode: e.response?.statusCode ?? 400,
                message: 'Failed to parse error response',
                errors: Errors(otp: ['Invalid OTP or verification failed']),
              ),
            );
          }
        } else {
          // No response data
          Logger.error('No response data from server');
          return Left(
            OtpErrorModel(
              statusCode: e.response?.statusCode ?? 500,
              message: e.message ?? 'Network error occurred',
              errors: Errors(otp: ['Unable to connect to server']),
            ),
          );
        }
      }

      // Handle non-Dio errors
      Logger.error('Non-Dio exception: ${e.runtimeType}');
      return Left(
        OtpErrorModel(
          statusCode: 500,
          message: 'Unexpected error occurred',
          errors: Errors(otp: ['Please check your connection and try again']),
        ),
      );
    }
  }

  Future<UserCredential> signInWithGoogle() {
    return firebaseServices.signInWithGoogle();
  }

  Future<void> signOut() {
    return firebaseServices.signOut();
  }



}