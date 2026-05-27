import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorFavoriteScreen extends StatefulWidget {
  const ExhibitorFavoriteScreen({super.key});

  @override
  State<ExhibitorFavoriteScreen> createState() =>
      _ExhibitorFavoriteScreenState();
}

class _ExhibitorFavoriteScreenState extends State<ExhibitorFavoriteScreen> {
  final FavoriteController favcontroller = Get.find<FavoriteController>();

  final AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    /// LOAD FAVORITES
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favcontroller.getExhibitorFavoriteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Obx(() {
        if (favcontroller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (favcontroller.exhibitorFavoriteList.isEmpty) {
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
                    "${favcontroller.exhibitorFavoriteList.length} / ${controller.totalExhibitorCount.value}",
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: favcontroller.exhibitorFavoriteList.length,

                  separatorBuilder: (_, _) => const Divider(),

                  itemBuilder: (context, index) {
                    final exhibitor =
                        favcontroller.exhibitorFavoriteList[index];

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
                                    exhibitor.txtComName,
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
                              onPressed: () async {
                                await favcontroller.toggleExhibitorFavorite(
                                  exhibitor.inid,
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
