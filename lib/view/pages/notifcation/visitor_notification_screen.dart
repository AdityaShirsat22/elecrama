import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/visitor_notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitorNotificationScreen extends StatelessWidget {
  VisitorNotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: appbar,

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              controller.notificationOn.value
                                  ? "Notification ON"
                                  : "Notification OFF",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              activeTrackColor: green,
                              activeThumbColor: white,
                              value: controller.notificationOn.value,
                              onChanged: (value) {
                                controller.updateVisitorNotification(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Obx(
                    () => Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              controller.emailOn.value
                                  ? "Email ON"
                                  : "Email OFF",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              activeTrackColor: green,
                              activeThumbColor: white,
                              value: controller.emailOn.value,
                              onChanged: (value) {
                                controller.updateEmail(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.notifications.isEmpty) {
                return const Center(child: Text("No Notifications Found"));
              }

              return ListView.separated(
                itemCount: controller.notifications.length,

                separatorBuilder: (context, index) => const Divider(height: 1),

                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];

                  return ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.visitormeetings);
                    },
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),

                    title: Text(
                      notification.value,
                      style: const TextStyle(fontSize: 18, height: 1.4),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        notification.createdDate,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    trailing: const Icon(Icons.chevron_right, size: 28),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
