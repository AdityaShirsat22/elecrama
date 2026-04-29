import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginpage.dart';
import 'package:flutter/material.dart';

class Dbsmloginscreen extends StatefulWidget {
  const Dbsmloginscreen({super.key});

  @override
  State<Dbsmloginscreen> createState() => _IotLoginScreenState();
}

class _IotLoginScreenState extends State<Dbsmloginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Loginpage(
        heading: "Enter your DBSM credentials",
        email: "Enter your delegate Id",
        password: "Enter Your Password",
        forgetpassword: () {},
        loginbuttonpress: () {},
      ),
    );
  }
}
