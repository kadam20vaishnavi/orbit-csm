import 'package:dio/dio.dart';
import 'package:orbit_csm/networking/dio.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksResModel.dart';
import 'package:orbit_csm/ui/login/LoginReqModel.dart';
import 'package:orbit_csm/ui/login/LoginResModel.dart';
import 'package:orbit_csm/util/Constants.dart';

import 'package:dio/dio.dart';

class ApiServices {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.BASE_URL, // Replace with your actual API base URL
      connectTimeout: Duration(seconds: 10), // Set reasonable timeout
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  // Generic method to handle all API requests
  Future<Response> _request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? token,
  }) async {
    try {
      final options = Options(
        method: method,
        headers: {
          'auth-token': token ?? '', // Ensure token is not null
          ...?headers, // Merge additional headers safely
        },
      );

      print("📡 Sending request: $method $endpoint");
      print("📦 Data: $data | Query: $queryParameters | Headers: ${options.headers}");

      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      print("✅ Response received: ${response.statusCode}");
      return response;
    } on DioException catch (e) {
      String errorMsg = "❌ API call failed: ${e.message}";

      if (e.type == DioExceptionType.connectionTimeout) {
        errorMsg = "⏳ Connection timed out. Please check your internet.";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMsg = "⏳ Server took too long to respond.";
      } else if (e.type == DioExceptionType.connectionError) {
        errorMsg = "🌐 No internet connection.";
      } else if (e.type == DioExceptionType.badResponse) {
        errorMsg = "🚨 Server error: ${e.response?.statusCode}";
      }

      print(errorMsg);
      throw Exception(errorMsg);
    } catch (e) {
      print("🚨 Unexpected error: $e");
      throw Exception("Unexpected error occurred.");
    }
  }

  // Authenticate user
  Future<Response> loginUser(LoginReqModel model) {
    return _request(
      method: 'POST',
      endpoint: '/user/api/v1/userLogin',
      data: model.toJson(),
    );
  }

  // Get Open Tasks List
  Future<Response> getOpenTasksList(String intskst_id, String daysAgo, String startDate, String endDate, String token) {
    return _request(
      method: 'GET',
      queryParameters: {
        'intskst_id': intskst_id,
        'daysAgo': daysAgo,
        'startDate': startDate,
        'endDate': endDate,
      },
      endpoint: "/incident/api/v1/getTaskList",
      token: token,
    );
  }
}
