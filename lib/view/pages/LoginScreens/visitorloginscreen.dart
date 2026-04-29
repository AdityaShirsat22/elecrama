import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginpage.dart';
import 'package:flutter/material.dart';

class Visitorloginscreen extends StatefulWidget {
  const Visitorloginscreen({super.key});

  @override
  State<Visitorloginscreen> createState() => _VisitorloginscreenState();
}

class _VisitorloginscreenState extends State<Visitorloginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Loginpage(
        heading: "Visitor Login",
        email: "Enter Visitor ID / Email",
        password: "Enter Your Password",
        forgetpassword: () {},
        loginbuttonpress: () {},
        register: () {},
      ),
    );
  }
}
