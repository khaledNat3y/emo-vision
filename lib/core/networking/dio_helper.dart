import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constant.dart';

class DioHelper {
  static Dio? _dio;

  DioHelper._();

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(_AuthInterceptor(dio));
    return dio;
  }

  static Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.get(endPoint, queryParameters: query);
    } catch (e) {
      log("Error in GET: $e");
      rethrow;
    }
  }

  static Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.post(endPoint, data: data);
    } catch (e) {
      log("Error in POST: $e");
      rethrow;
    }
  }

  static Future<Response> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.put(endPoint, data: data);
    } catch (e) {
      log("Error in PUT: $e");
      rethrow;
    }
  }

  static Future<Response> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.delete(endPoint, data: data);
    } catch (e) {
      log("Error in DELETE: $e");
      rethrow;
    }
  }
}

// Auth Interceptor
// Attaches Bearer token to every request.
// On 401: tries to refresh the token, retries original request once.
// On refresh failure: clears credentials.
class _AuthInterceptor extends Interceptor {
  final Dio _dio;

  // Separate Dio instance for refresh to avoid interceptor loop
  final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  _AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Don't attach token for public endpoints
    final skipPaths = [
      ApiConstants.login,
      ApiConstants.register,
      ApiConstants.verifyEmail,
      ApiConstants.forgotPassword,
      ApiConstants.resetPassword,
      ApiConstants.resendOtp,
    ];

    if (!skipPaths.contains(options.path)) {
      final token = await SharedPrefHelper.getSecuredString(
        CacheConstants.accessToken,
      );
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    final refreshToken = await SharedPrefHelper.getSecuredString(
      CacheConstants.refreshToken,
    );
    // If no refresh token:
    // user session is invalid
    if (refreshToken == null || refreshToken.isEmpty) {
      await _clearCredentials();
      handler.next(err);
      return;
    }

    try {
      final refreshResponse = await _refreshDio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = refreshResponse.data['accessToken'] as String?;
      final newRefreshToken = refreshResponse.data['refreshToken'] as String?;

      if (newAccessToken == null || newAccessToken.isEmpty) {
        await _clearCredentials();
        handler.next(err);
        return;
      }

      await SharedPrefHelper.setSecuredString(
        CacheConstants.accessToken,
        newAccessToken,
      );
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await SharedPrefHelper.setSecuredString(
          CacheConstants.refreshToken,
          newRefreshToken,
        );
      }

      // Retry original request with new token
      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await _dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      await _clearCredentials();
      handler.next(err);
    }
  }

  Future<void> _clearCredentials() async {
    await SharedPrefHelper.clearAllSecuredData();
    await SharedPrefHelper.removeData(CacheConstants.userEmail);
    await SharedPrefHelper.removeData(CacheConstants.userName);
  }
}
