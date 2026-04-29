import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/pages/LoginScreens/b2bbuyerlogin.dart';
import 'package:elecrama/view/pages/LoginScreens/exhibitorloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/iotloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/visitorloginscreen.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view/widgets/loginbuttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Multipleloginscreen extends StatefulWidget {
  const Multipleloginscreen({super.key});

  @override
  State<Multipleloginscreen> createState() => _MultipleloginscreenState();
}

class _MultipleloginscreenState extends State<Multipleloginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 15),
              Text("Select Your Login Option", style: TextStyle(fontSize: 18)),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {
                  Get.to(() => Exhibitorloginscreen());
                },
                bgColor: orange,
                text: "EXHIBITOR LOGIN",
              ),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {
                  Get.to(() => Visitorloginscreen());
                },
                bgColor: blue,
                text: "VISITOR LOGIN",
              ),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {
                  Get.to(() => B2bbuyerlogin());
                },
                bgColor: green,
                text: "B2B BUYER LOGIN",
              ),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {
                  Get.to(() => IotLoginScreen());
                },
                bgColor: purple,
                text: "IOT LOGIN",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
