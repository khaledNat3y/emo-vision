import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
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
        baseUrl: ApiConstants.videoProcessingBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(PrettyDioLogger());
    // dio.interceptors.add(SupabaseAuthInterceptor());
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

// Supabase Auth Interceptor - attaches Supabase JWT to all requests
// class SupabaseAuthInterceptor extends Interceptor {
//   final SupabaseAuthService _supabaseAuthService = SupabaseAuthService();

//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final token = await _supabaseAuthService.getAccessToken();
//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }
// }
