import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/controller/exhibitor_notification_controller.dart';

class ExhibitorNotificationScreen extends StatelessWidget {
  ExhibitorNotificationScreen({super.key});

  final ExhibitorNotificationController controller = Get.put(
    ExhibitorNotificationController(),
  );

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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.notificationOn.value
                                ? "Notification ON"
                                : "Notification OFF",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                activeTrackColor: green,
                                activeThumbColor: white,
                                value: controller.notificationOn.value,
                                onChanged:
                                    controller.updateExhibitorNotification,
                              ),
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.emailOn.value ? "Email ON" : "Email OFF",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                activeTrackColor: green,
                                activeThumbColor: white,
                                value: controller.emailOn.value,
                                onChanged: controller.updateExhibitorEmail,
                              ),
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

              return RefreshIndicator(
                onRefresh: controller.refreshNotifications,
                child: ListView.separated(
                  itemCount: controller.notifications.length,

                  separatorBuilder: (_, __) => const Divider(height: 1),

                  itemBuilder: (context, index) {
                    final item = controller.notifications[index];

                    return ListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.exhibitormeetings);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      title: Text(
                        item.value,
                        style: const TextStyle(fontSize: 15, height: 1.4),
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          item.createdDate,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),

                      trailing: const Icon(Icons.chevron_right),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
