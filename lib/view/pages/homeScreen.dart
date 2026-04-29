import 'package:carousel_slider/carousel_slider.dart';
import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/pages/LoginScreens/multipleloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/visitorloginscreen.dart';
import 'package:elecrama/view/pages/qrscreen.dart';
import 'package:elecrama/view/widgets/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => Qrscreen());
            },
            icon: Icon(Icons.qr_code, color: white),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => Multipleloginscreen());
            },
            icon: Icon(Icons.person, color: white),
          ),
          IconButton(
            onPressed: () {
              Get.off(() => Multipleloginscreen());
            },
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image(image: AssetImage("assets/image1.jpeg")),
                Image(image: AssetImage("assets/image2.jpeg")),
                Image(image: AssetImage("assets/image3.jpeg")),
                Image(image: AssetImage("assets/image4.jpeg")),
                Image(image: AssetImage("assets/image5.jpeg")),
              ],
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                viewportFraction: 1,
              ),
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
                        leading: Icon(Icons.dashboard, color: orange, size: 30),
                        title: Text("My Dashboard"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        onTap: () {},
                      ),
                      Divider(color: orange, thickness: 0.1),
                      ListTile(
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
                        leading: Icon(Icons.dashboard, color: green, size: 30),
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
      ),
    );
  }
}
