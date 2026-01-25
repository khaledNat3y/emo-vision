import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/api_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  Dio? dio;
  DioHelper() {
    initDio();
  }

  void initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger());
  }

  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio!.get(endPoint, queryParameters: query);
    } catch (e) {
      log("Error in GET: $e");
      rethrow;
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio!.post(endPoint, data: data);
    } catch (e) {
      log("Error in POST: $e");
      rethrow;
    }
  }

  Future<Response> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await dio!.put(endPoint, data: data);
      return response;
    } catch (e) {
      log("Error in put request: ${e.toString()}");
      rethrow;
    }
  }

  Future<Response> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await dio!.delete(endPoint, data: data);
      return response;
    } catch (e) {
      log("Error in delete request: ${e.toString()}");
      rethrow;
    }
  }
}