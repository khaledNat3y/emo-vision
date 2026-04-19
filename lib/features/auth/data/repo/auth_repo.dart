import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/firebase_services.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/forgot_password_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_response.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/logout_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/me_response.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/register_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/register_response.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/resend_otp_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/reset_password_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/verify_email_request_body.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constant/cache_constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/services/auth_service.dart';

// Either<String, T>
// Left(String)  → error message to show the user
// Right(T)      → success data

class AuthRepo {
  final AuthService _authService;
  final FirebaseServices _firebaseServices;

  AuthRepo(this._authService, this._firebaseServices);

  // Email / Password

  Future<Either<String, LoginResponse>> login(LoginRequestBody body) async {
    try {
      final response = await _authService.loginUser(body: body);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, RegisterResponse>> register(
    RegisterRequestBody body,
  ) async {
    try {
      final response = await _authService.register(body: body);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> verifyEmail(
    VerifyEmailRequestBody body,
  ) async {
    try {
      await _authService.verifyEmail(body: body);
      return const Right('Email verified successfully');
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> logout() async {
    try {
      final storedRefreshToken = await SharedPrefHelper.getSecuredString(
        CacheConstants.refreshToken,
      );
      await _authService.logout(
        body: LogoutRequestBody(refreshToken: storedRefreshToken ?? ''),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, MeResponse>> getMe() async {
    try {
      final response = await _authService.getMe();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Google

  Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      final result = await _firebaseServices.signInWithGoogle();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> signOutGoogle() async {
    await _firebaseServices.signOut();
  }

  Future<String> forgotPassword(String email) async {
    try {
      final response = await _authService.forgotPassword(
        body: ForgotPasswordRequestBody(email: email),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> resetPassword({required ResetPasswordRequestBody body}) async {
    try {
      final response = await _authService.resetPassword(
        body: ResetPasswordRequestBody(
          email: body.email,
          otp: body.otp,
          newPassword: body.newPassword,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> resendOtp({required ResendOtpRequestBody body}) async {
    try {
      final response = await _authService.resendOtp(
        body: ResendOtpRequestBody(email: body.email),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Error Helper

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond. Please try again.';
      case DioExceptionType.sendTimeout:
        return 'Request timed out while sending. Please try again.';
      case DioExceptionType.badResponse:
        // Try to extract message from response body
        try {
          final data = e.response?.data;
          if (data is Map<String, dynamic>) {
            final message = data['message']?.toString();
            if (message != null && message.isNotEmpty) return message;

            // Try errors map
            final errors = data['errors'];
            if (errors is Map<String, dynamic>) {
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return firstError.first.toString();
              }
            }
          }
        } catch (_) {}
        return 'Server error (${e.response?.statusCode}). Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
