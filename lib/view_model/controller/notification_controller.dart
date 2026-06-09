import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/notificationmodel.dart';
import '../../data/repositories/notification_service.dart';
import 'authController.dart';

class NotificationController extends GetxController {
  final NotificationService _service = NotificationService();

  final authController = Get.find<AuthController>();

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  RxBool isLoading = false.obs;

  RxBool notificationOn = false.obs;
  RxBool emailOn = false.obs;

  int visitorId = 0;

  @override
  void onInit() {
    super.onInit();

    visitorId = authController.visitor.value?.inId ?? 0;

    notificationOn.value =
        authController.visitor.value?.blNotifictnStatus == "1";

    emailOn.value = authController.visitor.value?.blMailNotification == "1";

    getVisitorNotifications();
  }

  Future<void> getVisitorNotifications() async {
    try {
      isLoading.value = true;

      final result = await _service.getVisitorNotifications(visitorId);

      notifications.assignAll(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateVisitorNotification(bool value) async {
    notificationOn.value = value;

    final success = await _service.updateVisitorNotificationStatus(
      visitorId: visitorId,
      status: value ? 1 : 0,
    );

    if (success) {
      authController.visitor.update((user) {
        user?.blNotifictnStatus = value ? "1" : "0";
      });

      Get.snackbar(
        snackPosition: SnackPosition.BOTTOM,
        "Tap",
        "Notifications status updated Successfully",
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 1),
      );
    }
  }

  Future<void> updateEmail(bool value) async {
    emailOn.value = value;

    final success = await _service.updateVisitorMailNotificationStatus(
      visitorId: visitorId,
      status: value ? 1 : 0,
    );

    if (success) {
      authController.visitor.update((user) {
        user?.blMailNotification = value ? "1" : "0";
      });

      Get.snackbar(
        snackPosition: SnackPosition.BOTTOM,
        "Tap",
        "Email Notifications status updated Successfully",
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 1),
      );
    }
  }
}
