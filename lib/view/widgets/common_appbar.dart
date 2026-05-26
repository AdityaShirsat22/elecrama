import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/pages/LoginScreens/multipleloginscreen.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AppBar appbar = AppBar(
  backgroundColor: orange,
  leading: IconButton(
    onPressed: () {
      Get.offAllNamed('/home');
    },
    icon: Icon(Icons.home, color: white),
  ),
  actions: [
    IconButton(
      onPressed: () {
        final authController = Get.find<AuthController>();
        if (authController.isLoggedIn()) {
          final role = authController.getRole();
          if (role == 'visitor') {
            Get.toNamed('/qrscreen');
            return;
          }
          if (role == 'exhibitor') {
            Get.toNamed('/qrscreen');
            return;
          }
        }
        Get.to(() => Multipleloginscreen());
      },
      icon: Icon(Icons.qr_code, color: white),
    ),
    IconButton(
      onPressed: () {
        final authController = Get.find<AuthController>();
        if (authController.isLoggedIn()) {
          final role = authController.getRole();
          if (role == 'visitor') {
            Get.toNamed('/visitorHome');
            return;
          }
          if (role == 'exhibitor') {
            Get.toNamed('/exhibitorHome');
            return;
          }
        }
        Get.to(() => Multipleloginscreen());
      },
      icon: Icon(Icons.person, color: white),
    ),
    IconButton(
      onPressed: () {
        final authController = Get.find<AuthController>();
        if (authController.isLoggedIn()) {
          final role = authController.getRole();
          if (role == 'visitor') {
            Get.toNamed(AppRoutes.visitorfav);
            return;
          }
          if (role == 'exhibitor') {
            Get.toNamed('/exhibitorsetting');
            return;
          }
        }
        Get.to(() => Multipleloginscreen());
      },
      icon: Icon(Icons.star, color: white),
    ),
    IconButton(
      onPressed: () {
        final authController = Get.find<AuthController>();
        if (authController.isLoggedIn()) {
          final role = authController.getRole();
          if (role == 'visitor') {
            Get.toNamed('/visitorsetting');
            return;
          }
          if (role == 'exhibitor') {
            Get.toNamed('/exhibitorsetting');
            return;
          }
        }
        Get.to(() => Multipleloginscreen());
      },
      icon: Icon(Icons.settings, color: white),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.notifications, color: white),
    ),
  ],
  bottom: PreferredSize(
    preferredSize: Size.fromHeight(40),
    child: Container(
      color: orange,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextButton.icon(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back, color: white, size: 20),
        label: Text("Back", style: TextStyle(color: white, fontSize: 18)),
      ),
    ),
  ),
);
