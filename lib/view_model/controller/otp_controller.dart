import 'package:elecrama/data/model/otp_response_model.dart';
import 'package:elecrama/data/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final AuthService otpService = AuthService();

  final otpTextController = TextEditingController();

  RxBool isLoading = false.obs;

  Rx<OtpResponseModel?> otpData = Rx<OtpResponseModel?>(null);
  RxString generatedOtp = ''.obs;

  Future<void> sendOtp(String email) async {
    try {
      isLoading.value = true;
      final response = await otpService.generateOtp(email);
      print(response.data);

      final data = OtpResponseModel.fromJson(response.data);
      otpData.value = data;

      if (data.code == "1") {
        generatedOtp.value = data.otp ?? '';
        Get.snackbar("Success", data.message ?? "OTP Sent");
      } else {
        Get.snackbar("Error", data.message ?? "Something went wrong");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateOtp(String email) async {
    await sendOtp(email);
  }

  void verifyOtp() {
    if (otpTextController.text.trim() == otpData.value?.otp) {
      Get.snackbar("Success", "OTP Verified Successfully");
      Get.offAllNamed('/exhibitorHome');
    } else {
      Get.snackbar("Error", "Invalid OTP");
    }
  }
}
