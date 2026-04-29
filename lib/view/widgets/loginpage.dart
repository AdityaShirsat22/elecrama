import 'package:elecrama/core/colors_theme.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  final String heading;
  final String email;
  final String password;
  final VoidCallback loginbuttonpress;
  final VoidCallback forgetpassword;
  final VoidCallback? register;
  const Loginpage({
    super.key,
    required this.heading,
    required this.email,
    required this.password,
    required this.loginbuttonpress,
    required this.forgetpassword,
    this.register,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                heading,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: email,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: password,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: forgetpassword,
              child: Text(
                "Forget Passsword",
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),

            SizedBox(height: 25),
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
                onPressed: loginbuttonpress,
                child: Text(
                  "Login",
                  style: TextStyle(color: white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account?", style: TextStyle(fontSize: 15)),
                TextButton(
                  onPressed: register,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.lightBlue[600],
                      fontSize: 15,
                    ),
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
