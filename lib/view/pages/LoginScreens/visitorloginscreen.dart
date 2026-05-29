import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginpage.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Visitorloginscreen extends StatefulWidget {
  const Visitorloginscreen({super.key});

  @override
  State<Visitorloginscreen> createState() => _VisitorloginscreenState();
}

class _VisitorloginscreenState extends State<Visitorloginscreen> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> openLink() async {
    final Uri uri = Uri.parse(
      'https://elecrama25.ngauge.co.in/Visitors/Visitor_Forgot_Password.aspx',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          Loginpage(
            heading: "Visitor Login",
            email: "Enter Visitor ID / Email",
            password: "Enter Your Password",
            forgetpassword: openLink,
            onLogin: (email, password) async {
              final success = await _authController.visitorlogin(
                email,
                password,
              );
              if (success) {
                Get.offAllNamed(AppRoutes.visitorHome);
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont have an account?", style: TextStyle(fontSize: 15)),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.lightBlue[600], fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
