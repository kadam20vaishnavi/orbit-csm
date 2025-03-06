import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbit_csm/ui/login/LoginViewModel.dart';
import 'package:orbit_csm/util/colors.dart';
import 'package:orbit_csm/util/dimensions.dart';
import 'package:provider/provider.dart';

class LoginState extends StatefulWidget{
    const LoginState({super.key});

    @override
    State<LoginState> createState() => _LoginState();

 }

class _LoginState extends State<LoginState> {

  final TextEditingController txtUserName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(Dimensions.level3Margin(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(context),
                  SizedBox(height: Dimensions.level4Margin(context)),
                  _buildLoginCard(context, viewModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/png/orbit_logo.png',
          width: Dimensions.level3Size(context),
          height: Dimensions.level3Size(context),
        ),
        Text(
          "Customer Service Management",
          style: TextStyle(
            fontSize: Dimensions.largerTextSize(context),
            color: AppColors.burgundy,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context, LoginViewModel viewModel) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
        child: Column(
          children: [
            _buildTextField(txtUserName, "Enter Username", Icons.person),
            SizedBox(height: Dimensions.navigationTitleSize(context)),
            _buildTextField(txtPassword, "Enter Password", Icons.lock, isPassword: true),
            SizedBox(height: Dimensions.level4Margin(context)),
            _buildLoginButton(context, viewModel),
            SizedBox(height: Dimensions.level3Margin(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF800020)),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF800020),
            width: Dimensions.stepperMargin(context),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginViewModel viewModel) {
    return SizedBox(
      width: Dimensions.level5Size(context),
      height: Dimensions.level1Size(context),
      child: ElevatedButton(
        onPressed: () => viewModel.loginUser(txtUserName.text, txtPassword.text, context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: Dimensions.level2Padding(context)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF800020), Color(0xFFB22222)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text("Login", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}