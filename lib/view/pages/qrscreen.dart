import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/view/widgets/common_apppbar.dart';
import 'package:flutter/material.dart';

class Qrscreen extends StatelessWidget {
  const Qrscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(0),
                  ),
                ),
                child: Text("My QR Code", style: TextStyle(color: white)),
              ),
            ],
          ),
          Container(
            alignment: Alignment(-0.9, 1),
            child: Text(
              "SCAN AND CONNECT",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 120),

          InkWell(
            onTap: () {},
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFC107), Color(0xFFFF5722)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.badge, color: Colors.white, size: 60),
                  ),
                ),
                SizedBox(height: 30),
                Text("SCAN BADGE", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(height: 40, thickness: 1),
          SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 233, 81, 30),
                        Color.fromARGB(255, 255, 34, 97),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.store, color: Colors.white, size: 60),
                  ),
                ),
                SizedBox(height: 30),
                Text("SCAN STALL", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
