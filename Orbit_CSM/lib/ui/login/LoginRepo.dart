import 'package:dio/dio.dart';
import 'package:orbit_csm/networking/api_services.dart';
import 'package:orbit_csm/ui/login/LoginReqModel.dart';
import 'package:orbit_csm/ui/login/LoginResModel.dart';

class LoginRepo {

  final ApiServices apiService = ApiServices();

  Future<Response> loginApi(LoginReqModel model) async {
    return await apiService.loginUser(model) as Future<Response>;
  }

}
