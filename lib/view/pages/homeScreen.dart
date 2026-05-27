import 'package:carousel_slider/carousel_slider.dart';
import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/pages/LoginScreens/multipleloginscreen.dart';

import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends GetView<HomeController> {
  const Homescreen({super.key});

  Future<void> openLink(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: orange,
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
                  Get.toNamed(AppRoutes.exhibitorfav);
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
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 170,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1,
                ),
                items: controller.bannerList.map((banner) {
                  return GestureDetector(
                    onTap: () => openLink(banner.link),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FutureBuilder(
                        future: controller.getImage(banner.logoUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Icon(Icons.error);
                          }

                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),

              //expansiontile 1
              ExpansionTile(
                backgroundColor: orange,
                collapsedBackgroundColor: orange,
                collapsedTextColor: white,
                collapsedIconColor: white,
                iconColor: white,
                title: Text("PLAN YOUR VISIT", style: TextStyle(color: white)),
                children: [
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.dashboard,
                            color: orange,
                            size: 30,
                          ),
                          title: Text("My Dashboard"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          onTap: () {
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
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          onTap: () async {
                            Get.toNamed('/exhibitorlist');
                          },
                          minTileHeight: 20,
                          leading: Icon(Icons.people, color: orange, size: 30),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          title: Text("Exhibitors"),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(
                            Icons.home_filled,
                            color: orange,
                            size: 30,
                          ),
                          title: Text("Pavilions"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(
                            Icons.event_available,
                            color: orange,
                            size: 30,
                          ),
                          title: Text("Concurrent Events"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(Icons.people, color: orange, size: 30),
                          title: Text("Townhall Agenda"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(Icons.map, color: orange, size: 30),
                          title: Text("Plan Your Travel"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(Icons.event, color: orange, size: 30),
                          title: Text("Important Dates And Events"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(
                            Icons.app_registration,
                            color: orange,
                            size: 30,
                          ),
                          title: Text("Register"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: orange, thickness: 0.1),
                        ListTile(
                          leading: Icon(Icons.email, color: orange, size: 30),
                          title: Text("Invite Friends"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //expansion tile 2
              ExpansionTile(
                backgroundColor: blue,
                collapsedBackgroundColor: blue,
                collapsedTextColor: white,
                collapsedIconColor: white,
                iconColor: white,
                title: Text("AT THE VENUE", style: TextStyle(color: white)),
                children: [
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.dashboard, color: blue, size: 30),
                          title: Text("Venue and Layout"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: blue, thickness: 0.1),
                        ListTile(
                          leading: Icon(Icons.analytics, color: blue, size: 30),
                          title: Text("Facilities on Ground"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          onTap: () {},
                        ),
                        Divider(color: blue, thickness: 0.1),
                        ListTile(
                          leading: Icon(
                            Icons.support_agent,
                            color: blue,
                            size: 30,
                          ),
                          title: Text("Support"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          onTap: () {},
                        ),
                        Divider(color: blue, thickness: 0.1),
                        ListTile(
                          leading: Icon(
                            Icons.feedback_sharp,
                            color: blue,
                            size: 30,
                          ),
                          title: Text("Feedback"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //expansiontile 3
              ExpansionTile(
                backgroundColor: green,
                collapsedBackgroundColor: green,
                collapsedTextColor: white,
                collapsedIconColor: white,
                iconColor: white,
                title: Text("ABOUT EVENT", style: TextStyle(color: white)),
                children: [
                  Container(
                    color: white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.dashboard,
                            color: green,
                            size: 30,
                          ),
                          title: Text("About Event"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                        Divider(color: green, thickness: 0.3),
                        ListTile(
                          leading: Icon(
                            Icons.meeting_room,
                            color: green,
                            size: 30,
                          ),
                          title: Text("Organizers"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          onTap: () {},
                        ),
                        Divider(color: green, thickness: 0.3),
                        ListTile(
                          leading: Icon(
                            Icons.attach_money,
                            color: green,
                            size: 30,
                          ),
                          title: Text("Sponser"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
