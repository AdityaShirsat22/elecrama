import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/pages/LoginScreens/dbsmloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/rbmsloginscreen.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginbuttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

class B2bbuyerlogin extends StatefulWidget {
  const B2bbuyerlogin({super.key});

  @override
  State<B2bbuyerlogin> createState() => _B2bbuyerloginState();
}

class _B2bbuyerloginState extends State<B2bbuyerlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              SizedBox(height: 25),
              Text("Select Option", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Loginbuttons(
                bgColor: orange,
                text: "RBSM LOGIN",
                onpressed: () {
                  Get.to(() => Rbmsloginscreen());
                },
              ),
              SizedBox(height: 20),
              Loginbuttons(
                bgColor: blue,
                text: "DBSM LOGIN",
                onpressed: () {
                  Get.to(() => Dbsmloginscreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
