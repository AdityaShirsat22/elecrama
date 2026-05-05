import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitorProfileScreen extends StatelessWidget {
  VisitorProfileScreen({super.key});

  final controller = Get.find<AuthController>();

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: 260,
            child: Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Obx(() {
        final data = controller.visitor.value;

        if (data == null) {
          return Center(
            child: Text(
              'No Data',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final visitorId = data.userId ?? '';
        final fullName = '${data.firstName ?? ''} ${data.lastName ?? ''}'
            .trim();
        final organisation = data.organisation ?? '';
        final designation = data.designation ?? '';
        final mobile = data.mobileNo ?? '';
        final email = data.emailId ?? '';
        final city = data.city ?? '';
        final country = data.country ?? '';
        final qrpath = data.qrPath;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                // if (qrpath != null && qrpath.isNotEmpty)
                //   Image.network(qrpath, height: 150, width: 150)
                // else
                //   SizedBox(height: 150),
                SizedBox(height: 30),
                _infoRow("Visitor ID", visitorId),
                Divider(),
                _infoRow('Name', fullName),
                Divider(),
                _infoRow('Organization', organisation),
                Divider(),
                _infoRow('Designation', designation),
                Divider(),
                _infoRow('Mobile', mobile),
                Divider(),
                _infoRow('Email', email),
                Divider(),
                _infoRow('City', city),
                Divider(),
                _infoRow('Country', country),
                Divider(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
