import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/visitior_fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitorFavoriteScreen extends StatelessWidget {
  VisitorFavoriteScreen({super.key});

  final FavoriteController controller = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favoriteList.isEmpty) {
          return const Center(child: Text("No Favorites Found"));
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "FAVORITE LIST",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    controller.favoriteList.length.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: controller.favoriteList.length,

                  separatorBuilder: (_, __) => const Divider(),

                  itemBuilder: (context, index) {
                    final exhibitor = controller.favoriteList[index];

                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.exhibitorcompanyinfo,
                          arguments: exhibitor,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exhibitor.companyName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    "(HALL ${exhibitor.hallNo}    STALL : ${exhibitor.stallNo})",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                controller.toggleFavorite(
                                  exhibitor.exhibitorId,
                                );
                              },
                              icon: const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 35,
                              ),
                            ),

                            const Icon(Icons.arrow_forward_ios, size: 18),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
