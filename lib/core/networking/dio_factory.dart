import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  final Dio _dio;
  Dio get dio =>_dio;
  DioFactory() : _dio = Dio() {
    _dio.options
    ..connectTimeout = const Duration(minutes: 1)
    ..receiveTimeout = const Duration(minutes: 1)
    ..sendTimeout = const Duration(minutes: 3);
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        // filter: (options, args){
        //     // don't print requests with uris containing '/posts' 
        //     if(options.path.contains('/posts')){
        //       return false;
        //     }
        //     // don't print responses with unit8 list data
        //     return !args.isResponse || !args.hasUint8ListData;
        //   }
      )
    );

  }
}