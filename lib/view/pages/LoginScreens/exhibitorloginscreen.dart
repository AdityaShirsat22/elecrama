import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exhibitorloginscreen extends StatefulWidget {
  const Exhibitorloginscreen({super.key});

  @override
  State<Exhibitorloginscreen> createState() => _ExhibitorloginscreenState();
}

class _ExhibitorloginscreenState extends State<Exhibitorloginscreen> {
  final controller = Get.find<AuthController>();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Text(
                  "Exhibitor Login",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 15),
              Form(
                key: _formkey,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Email Id",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "* required";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(blue),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState?.validate() ?? false) {
                      String email = emailController.text.trim();

                      if (email.isEmpty) return;

                      bool success = await controller.getExhibitorDetails(
                        email,
                      );

                      if (success) {
                        Get.toNamed('/exhibitorDetails');
                      } else {
                        Get.snackbar("Error", "Email not found");
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: white, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 15),

              Text(
                "NOTE:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "- Please use the email ID that was submitted by your organization for your Exihibitor Badge registration",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 2),
              Text(
                "- You will recieve your One Time Login Code on your registered email.",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 2),
              Text(
                "- If your email is not registered then please contact you team responsible for submitting the data for 'Exhibitor Badges'",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
