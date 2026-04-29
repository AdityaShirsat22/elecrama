import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/pages/homeScreen.dart';
import 'package:elecrama/view/pages/qrscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AppBar appbar = AppBar(
  backgroundColor: orange,
  leading: IconButton(
    onPressed: () {
      Get.offAll(() => Homescreen());
    },
    icon: Icon(Icons.home, color: white),
  ),
  actions: [
    IconButton(
      onPressed: () {
        Get.off(() => Qrscreen());
      },
      icon: Icon(Icons.qr_code, color: white),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.person, color: white),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.star, color: white),
    ),
    IconButton(
      onPressed: () {},
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
