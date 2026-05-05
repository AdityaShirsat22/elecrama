import 'package:dio/dio.dart';
import 'package:elecrama/data/repositories/auth_service.dart';
import 'package:elecrama/data/repositories/hiveservice.dart';
import 'package:elecrama/data/model/visitorModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _service = Get.find<AuthService>();
  final Hiveservice _hive = Get.find<Hiveservice>();
  var exhibitor = Rxn<Record>();
  var visitor = Rxn<VisitorRecord>();

  var isLoading = false.obs;

  bool isLoggedIn() {
    return _hive.isloggedIn();
  }

  String getRole() {
    return _hive.getRole() ?? '';
  }

  void setLoggedInUser(String role) {
    _hive.saveRole(role);
    _hive.setLoggedIn(true);
  }

  void saveUserEmail(String email) {
    _hive.saveUserEmail(email);
  }

  String? getUserEmail() {
    return _hive.getUserEmail();
  }

  void logout() {
    _hive.loggout();
  }

  Future<bool> visitorlogin(String user, String pass) async {
    try {
      isLoading.value = true;
      final response = await _service.visitorLogin(
        userId: user.trim(),
        password: pass.trim(),
      );
      final data = response.data;
      final code = data["Code"];
      final isSuccess = code == 1 || code == "1" || code == true;

      if (isSuccess) {
        // Save userId for visitor
        saveUserEmail(user.trim());
        // Save password for visitor
        _hive.saveUserPassword(pass.trim());
        setLoggedInUser('visitor');
        Get.snackbar(
          "Success",
          "Login Successful",
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.green[700],
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
        );
        return true;
      } else {
        final message =
            data["Message"] ?? data["message"] ?? "Enter valid id and password";
        Get.snackbar(
          "",
          message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: const Color.fromARGB(221, 182, 89, 89),
          colorText: Colors.white,
          icon: const Icon(Icons.error_outline, color: Colors.white),
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
        );
        return false;
      }
    } catch (e) {
      final message = e is DioException
          ? e.response?.data?.toString() ?? e.message
          : 'Network or server error';
      Get.snackbar(
        "",
        message!,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: const Color.fromARGB(221, 192, 92, 92),
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        borderRadius: 10,
        margin: const EdgeInsets.all(16),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  //visitor details
  Future<bool> getVisitorDetails(String userId) async {
    try {
      isLoading.value = true;

      final password = _hive.getUserPassword() ?? '';

      final data = await _service.fetchVisitorDetails(userId, password);

      if (data != null) {
        visitor.value = data;
        return true;
      }

      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
