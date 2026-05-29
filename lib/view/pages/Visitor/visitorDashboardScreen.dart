import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Visitordashboardscreen extends StatefulWidget {
  const Visitordashboardscreen({super.key});

  @override
  State<Visitordashboardscreen> createState() =>
      _ExhibitordashboardscreenState();
}

class _ExhibitordashboardscreenState extends State<Visitordashboardscreen> {
  final controller = Get.find<AuthController>();
  var orange = Color.fromARGB(255, 255, 109, 24);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20, 15, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Visitor Dashboard",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.blue[800],
                      ),
                      title: Text(
                        'Scan Contacts',
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Get.snackbar(
                          'Tap',
                          'Scan Contacts clicked',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.business, color: Colors.blue[800]),
                      title: Text(
                        'Favorite Companies',
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Get.toNamed(AppRoutes.visitorfav);
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.people, color: Colors.blue[800]),
                      title: Text(
                        'My Meetings',
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Get.snackbar(
                          'Tap',
                          'My Meetings clicked',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.contact_phone,
                        color: Colors.blue[800],
                      ),
                      title: Text(
                        'Important Contacts',
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Get.snackbar(
                          'Tap',
                          'Important Contacts clicked',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.blue[800]),
                      title: Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () async {
                        final userId = controller.getUserEmail();
                        if (userId == null || userId.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "No visitor ID found. Please login again.",
                          );
                          return;
                        }

                        bool success = await controller.getVisitorDetails(
                          userId,
                        );

                        if (success) {
                          Get.toNamed(AppRoutes.visitorprofile);
                        } else {
                          Get.snackbar("Error", "Failed to load profile");
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
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
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          confirm: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(green),
                            ),
                            onPressed: () {
                              Get.offAllNamed('/home');
                              controller.logout();
                            },
                            child: Text(
                              "yes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
