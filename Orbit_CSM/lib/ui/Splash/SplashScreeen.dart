import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orbit_csm/ui/Dashboard/DashboardState.dart';
import 'package:orbit_csm/ui/login/LoginState.dart';
import 'package:orbit_csm/util/colors.dart';
import 'package:orbit_csm/util/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:orbit_csm/util/preference.dart';
import 'package:orbit_csm/util/Constants.dart';
import 'package:orbit_csm/util/string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  bool _isTextVisible = false;
  double _logoOpacity = 0.0;

  @override
  void initState(){
    super.initState();
    _startLogoAnimation();
    _startTextAnimation();
    _navigateToNextScreen();
  }

  void _startLogoAnimation() {
    // Fade in the logo after a small delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logoOpacity = 1.0;
      });
    });
  }

  void _startTextAnimation() {
    // Fade in the text after a longer delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTextVisible = true;
      });
    });
  }

  void _navigateToNextScreen() {
    // Redirect to the login screen after 4 seconds
    Timer(const Duration(seconds: 4), () {

      //Save login token in preferances
      String? loginToken =  Preference.getString(Constants.LOGIN_TOKEN) ;
      // print("checkLoginToken $loginToken");

      //check preferences empty
      if (loginToken == null || loginToken.isEmpty) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginState()),
      );

      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardState()),
        );
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change color if needed
      body: Column(
        children: [
          // Text at the top
          Padding(
            padding: EdgeInsets.only(top: Dimensions.level3Size(context)), // Adjust as needed
            child: Text(
              "Customer Service Management",
              style: TextStyle(
                fontSize: Dimensions.largerTextSize(context),
                fontWeight: FontWeight.bold,
                color: AppColors.burgundy,
              ),
            ),
          ),
          // Spacer to push the logo to the center
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left:50.0,top:0.0,right: 50.0,bottom: 0.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Center horizontally
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/png/at_app_logo.png', // Change to your logo
                      width: 80,
                      height: 80,// Adjust size if needed
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/png/orbit_logo.png', // Change to your logo
                      width: 80,
                      height: 80,// Adjust size if needed
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}