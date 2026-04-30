import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginpage.dart';
import 'package:flutter/material.dart';

class Rbmsloginscreen extends StatefulWidget {
  const Rbmsloginscreen({super.key});

  @override
  State<Rbmsloginscreen> createState() => _IotLoginScreenState();
}

class _IotLoginScreenState extends State<Rbmsloginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Loginpage(
        heading: "Enter your RBMS credentials",
        email: "Enter your delegate Id",
        password: "Enter Your Password",
        forgetpassword: () {},
        onLogin: (email, password) {
          
        },
      ),
    );
  }
}
