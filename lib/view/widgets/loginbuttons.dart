import 'package:elecrama/core/colors_theme.dart';
import 'package:flutter/material.dart';

class Loginbuttons extends StatelessWidget {
  final String text;
  final Color bgColor;
  final VoidCallback onpressed;
  const Loginbuttons({super.key, required this.bgColor, required this.text,required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
