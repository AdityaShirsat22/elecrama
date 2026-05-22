import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

class ExhibitorsettingScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();

  ExhibitorsettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(15, 30, 15, 10),
        child: Column(
          children: [
            ListTile(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(width: 0.1),
              ),
              leading: Icon(Icons.notifications, color: blue),
              title: Text("Notifications"),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Get.defaultDialog(
                  title: "logout",
                  middleText: "Are you sure you want to logout",
                  cancel: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(blue),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("No", style: TextStyle(color: Colors.white)),
                  ),
                  confirm: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(green),
                    ),
                    onPressed: () {
                      Get.offAllNamed('/home');
                      controller.logout();
                    },
                    child: Text("yes", style: TextStyle(color: Colors.white)),
                  ),
                );
              },
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(width: 0.1),
              ),
              leading: Icon(Icons.logout, color: blue),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            SizedBox(height: 20),
            ListTile(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(width: 0.1),
              ),
              leading: Icon(Icons.delete, color: blue),
              title: Text("Delete Account"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
