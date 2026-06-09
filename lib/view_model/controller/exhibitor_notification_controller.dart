import 'package:elecrama/data/model/notificationmodel.dart';
import 'package:elecrama/data/repositories/hiveservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/notification_service.dart';
import 'authController.dart';

class ExhibitorNotificationController extends GetxController {
  final NotificationService _service = NotificationService();

  final authController = Get.find<AuthController>();

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  RxBool isLoading = false.obs;

  RxBool notificationOn = false.obs;
  RxBool emailOn = false.obs;
  final Hiveservice hiveService = Hiveservice();

  int exhibitorId = 0;

  @override
  void onInit() {
    super.onInit();

    emailOn.value = hiveService.getExhibitorEmailNotification();

    exhibitorId =
        int.tryParse(authController.exhibitor.value?.exhibitorUserId ?? '0') ??
        0;

    getExhibitorNotifications();
  }

  Future<void> getExhibitorNotifications() async {
    try {
      isLoading.value = true;

      final result = await _service.getExhibitorNotifications(exhibitorId);

      notifications.assignAll(result);

      /// Notification switch state from API
      if (result.isNotEmpty) {
        notificationOn.value = result.first.notificationStatus == "1";
      }
    } catch (e) {
      debugPrint("Exhibitor Notification Error : $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateExhibitorNotification(bool value) async {
    notificationOn.value = value;

    final success = await _service.updateExhibitorNotificationStatus(
      exhibitorId: exhibitorId,
      status: value ? 1 : 0,
    );

    if (success) {
      await getExhibitorNotifications();

      Get.snackbar(
        "Success",
        "Notification status updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 1),
      );
    } else {
      notificationOn.value = !value;

      Get.snackbar("Error", "Failed to update notification status");
    }
  }

  Future<void> updateExhibitorEmail(bool value) async {
    emailOn.value = value;

    final success = await _service.updateExhibitorMailNotificationStatus(
      exhibitorId: exhibitorId,
      status: value ? 1 : 0,
    );

    if (success) {
      hiveService.saveExhibitorEmailNotification(value);
      Get.snackbar(
        "Success",
        "Email status updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 1),
      );
    } else {
      emailOn.value = !value;

      Get.snackbar(
        "Error",
        "Failed to update email status",
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 1),
      );
    }
  }

  Future<void> refreshNotifications() async {
    await getExhibitorNotifications();
  }
}
