
import 'package:dio/dio.dart';
import 'package:orbit_csm/util/Constants.dart';

class DioClient{
  static Dio? dio;

  static Dio getDioInstance(){
    dio ??= Dio(
      BaseOptions(
        baseUrl: Constants.BASE_URL, // Your API base URL
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );

    // Adding logging interceptor
    dio!.interceptors.add(
      LogInterceptor(
        request: true, // Log request data
        requestHeader: true, // Log request headers
        requestBody: true, // Log request body
        responseHeader: true, // Log response headers
        responseBody: true, // Log response body
        error: true, // Log errors
        logPrint: (object) {
          print(object); // Custom logger (can replace with your logging tool)
        },
      ),
    );
    return dio!;
  }
}