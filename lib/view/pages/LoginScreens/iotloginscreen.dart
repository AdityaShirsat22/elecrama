import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginpage.dart';
import 'package:flutter/material.dart';

class IotLoginScreen extends StatefulWidget {
  const IotLoginScreen({super.key});

  @override
  State<IotLoginScreen> createState() => _IotLoginScreenState();
}

class _IotLoginScreenState extends State<IotLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Loginpage(
        heading: "IOT Login",
        email: "Enter your email ",
        password: "Enter Your Password",
        forgetpassword: () {},
        onLogin: (email, password) {
          
        },
      ),
    );
  }
}
