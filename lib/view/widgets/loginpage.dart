import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/widgets/loginbuttons.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  final String heading;
  final String email;
  final String password;
  final Function(String email, String password) onLogin;
  final VoidCallback forgetpassword;

  const Loginpage({
    super.key,
    required this.heading,
    required this.email,
    required this.password,
    required this.onLogin,
    required this.forgetpassword,
  });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 30),

          Center(
            child: Text(
              widget.heading,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 20),

          Form(
            key: _formKey,
            child: Column(
              children: [

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: widget.email,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "* required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),


                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: widget.password,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "* required";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          TextButton(
            onPressed: widget.forgetpassword,
            child: Text(
              "Forget Password",
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),

          SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            child: Loginbuttons(
              bgColor: blue,
              onpressed: _submit,
              text: "Login",
            ),
          ),
        ],
      ),
    );
  }
}
