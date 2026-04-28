import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/widgets/common_apppbar.dart';
import 'package:elecrama/view/widgets/loginbuttons.dart';
import 'package:flutter/material.dart';

class Multipleloginscreen extends StatelessWidget {
  const Multipleloginscreen({super.key});

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
                onpressed: () {},
                bgColor: orange,
                text: "EXHIBITOR LOGIN",
              ),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {},
                bgColor: blue,
                text: "VISITOR LOGIN",
              ),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {},
                bgColor: green,
                text: "B2B BUYER LOGIN",
              ),
              SizedBox(height: 15),
              Loginbuttons(
                onpressed: () {},
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
