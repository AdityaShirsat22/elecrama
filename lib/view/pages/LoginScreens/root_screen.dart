import 'package:elecrama/view/pages/LoginScreens/multipleloginscreen.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    if (auth.isLoggedIn()) {
      final role = auth.getRole();

      /// VISITOR
      if (role == 'visitor') {
        Future.microtask(() {
          Get.offAllNamed('/home');
        });
      }
      /// EXHIBITOR
      else if (role == 'exhibitor') {
        Future.microtask(() {
          Get.offAllNamed('/home');
        });
      }
    }

    return Multipleloginscreen();
  }
}
