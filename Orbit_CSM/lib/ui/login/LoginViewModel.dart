import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbit_csm/networking/api_services.dart';
import 'package:orbit_csm/ui/Dashboard/DashboardState.dart';
import 'package:orbit_csm/ui/login/LoginRepo.dart';
import 'package:orbit_csm/ui/login/LoginReqModel.dart';
import 'package:orbit_csm/ui/login/LoginResModel.dart';
import 'package:orbit_csm/util/Constants.dart';
import 'package:orbit_csm/util/preference.dart';

class LoginViewModel extends ChangeNotifier{
  final LoginRepo _loginRepository = LoginRepo();
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final String _successMessage = '';
  String get successMessage => _successMessage;

  Future<LoginResModel?> loginUser(String userName,String password, BuildContext context) async {
    try {
      final model = LoginReqModel(fcmToken: "",macId: "42197d9c043fe992",name: userName,password: password,secretCode: "androidMob");

      final response = await _apiServices.loginUser(model);

      if (response.statusCode == 200) {

        final Map<String, dynamic> responseData = response.data;

        // Extract token
        String? token = responseData['token'];

        if (token != null) {
          Preference.saveString(Constants.LOGIN_TOKEN, response.data['token'].toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardState()),
          );
          print("Token saved: $token");
        } else {
          print("Token not found in response.");
        }

          return LoginResModel.fromJson(response.data); // ✅ Convert response to model

      } else {
        print("Login failed: ${response.statusCode} - ${response.data}");
        return null; // Handle API error
      }
    } catch (e) {
      print("Login Exception: $e");
      return null;
    }
  }

/*
  Future<LoginResModel> loginApi(String userName,String password, BuildContext context) async {

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    print("Login APi:");

    // Check if the phone number is empty or invalid
    if (userName.isEmpty && password.isEmpty) {
      print("Login APi username:PAssword");
      _errorMessage = 'Please enter a User name/Password';
    } else {

      print("Login Req Model:");
      final model = LoginReqModel(fcmToken: "",macId: "42197d9c043fe992",name: userName,password: password,secretCode: "androidMob");

      try {
        final response = await _loginRepository.loginApi(model);
        print("Login Success response: $response.statusCode");

        if (response.statusCode == 200) {

          Preference.saveString(Constants.LOGIN_TOKEN, response.data.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardState()),
          );

        } else {
          _errorMessage = response.data ?? 'Failed to Login';
          print('Error: failed $_errorMessage');
        }
      } catch (error) {
        print('Error: exception $error');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
      return;
    }
    _isLoading = false;
    notifyListeners();
  }
*/

}