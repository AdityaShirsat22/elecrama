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
      body: Column(
        children: [
          Loginpage(
            heading: "Visitor Login",
            email: "Enter Visitor ID / Email",
            password: "Enter Your Password",
            forgetpassword: () {},
            onLogin: (email, password) {
              print(email);
              print(password);
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
