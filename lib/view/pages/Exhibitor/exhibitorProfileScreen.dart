import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exhibitorprofilescreen extends StatelessWidget {
  Exhibitorprofilescreen({super.key});

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
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              softWrap: true,
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
        final data = controller.exhibitor.value;

        if (data == null) {
          return Center(
            child: Text(
              'No Data',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final exhibitorBadgeNo = data.exhibitorBadgeNo ?? '';
        final name = data.stName ?? '';
        //final company = data.stCompany ?? '';
        final designation = data.stDesignation ?? '';
        final mobile = data.stMobileNo ?? '';
        final email = data.stEmailId ?? '';
        //final country = data.stcountry ?? '';
        final qrpath = data.qrPath;
        final exhibitorid = data.exhibitorId ?? '';
        final exhibitoruserid = data.exhibitorUserId ?? '';

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Image.network(qrpath ?? '', height: 150, width: 150),

                SizedBox(height: 30),

                _infoRow("Exhibitor Badge No", exhibitorBadgeNo),
                Divider(),
                _infoRow('Name', name),
                Divider(),
                _infoRow('Exhibitor id', exhibitorid),
                Divider(),
                _infoRow('Designation', designation),
                Divider(),
                _infoRow('Mobile', mobile),
                Divider(),
                _infoRow('Email', email),
                Divider(),
                _infoRow('Exhibitor User id', exhibitoruserid),
                Divider(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
