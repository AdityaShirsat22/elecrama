import 'dart:math';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorDetailsScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();
  final OtpController otpcontroller = Get.put(OtpController());

  ExhibitorDetailsScreen({super.key});

  String _maskedEmail(String email) {
    //if (email.isEmpty) return '';
    final lower = email.toUpperCase();
    final atIndex = lower.indexOf('@');

    if (atIndex <= 2 || lower.length <= 6) return lower;

    final prefix = lower.substring(0, min(2, atIndex));
    final suffix = lower.contains('.')
        ? lower.substring(lower.lastIndexOf('.'))
        : lower.substring(max(lower.length - 3, 0));
    final starCount = max(0, lower.length - prefix.length - suffix.length);
    return prefix + '*' * starCount + suffix;
  }

  String _maskedMobile(String mobile) {
    if (mobile.isEmpty) return '';
    final filtered = mobile.trim();
    if (filtered.length <= 5) return filtered;
    final prefix = filtered.substring(0, 2);
    final suffix = filtered.substring(max(filtered.length - 3, 2));
    final stars = '*' * max(0, filtered.length - prefix.length - suffix.length);
    return prefix + stars + suffix;
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            //textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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

        final name = data.stName ?? '';
        final org = data.stCompany ?? '';
        final email = _maskedEmail(data.stEmailId ?? '');
        final mobile = _maskedMobile(data.stMobileNo ?? '');

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Text(
                  'The email is linked with the following details in our Exhibitor Database',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 18),

                Container(
                  //width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _infoRow('Name', name),
                      Divider(),
                      _infoRow('Organization', org),
                      Divider(),
                      _infoRow('Email', email),
                      Divider(),
                      _infoRow('Mobile', mobile),
                      SizedBox(height: 24),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () async {
                            await otpcontroller.sendOtp(data.stEmailId ?? '');
                            Get.toNamed(
                              '/logincodescreen',
                              arguments: data.stEmailId ?? '',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            'GET LOGIN CODE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
      }),
    );
  }
}
