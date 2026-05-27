import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorList extends StatefulWidget {
  const ExhibitorList({super.key});

  @override
  State<ExhibitorList> createState() => _ExhibitorListState();
}

class _ExhibitorListState extends State<ExhibitorList> {
  final favController = Get.find<FavoriteController>();
  final controller = Get.find<AuthController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// LOAD EXHIBITOR LIST
      await controller.getExhitorsList();

      final authController = Get.find<AuthController>();

      /// LOAD VISITOR FAVORITES
      if (authController.getRole() == 'visitor') {
        await favController.getVisitorFavoriteList();
      }
      /// LOAD EXHIBITOR FAVORITES
      else if (authController.getRole() == 'exhibitor') {
        await favController.getExhibitorFavoriteList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Obx(() {
        favController.visitorFavoriteIds.length;
        favController.exhibitorFavoriteIds.length;

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final exhibitorLists = controller.exhibitorList;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "EXHIBITOR LIST",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "${exhibitorLists.length} / ${controller.totalExhibitorCount.value}",
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: const [
                      Icon(Icons.filter_alt, color: Colors.blue, size: 32),
                      Text("Filter"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) =>
                      controller.getExhitorsList(search: value),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    prefixIcon: const Icon(Icons.search, size: 22),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 34,
                      minHeight: 34,
                    ),
                    hintText: "Search by Company / Products Name",
                    hintStyle: const TextStyle(fontSize: 13),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () {
                              searchController.clear();
                              controller.getExhitorsList();
                            },
                          )
                        : null,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 34,
                      minHeight: 34,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.separated(
                  itemCount: exhibitorLists.length,

                  separatorBuilder: (_, _) => const Divider(),

                  itemBuilder: (context, index) {
                    final exhibitor = exhibitorLists[index];

                    return Container(
                      key: ValueKey(exhibitor.inid),

                      child: InkWell(
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "(${exhibitor.hallNo}    STALL : ${exhibitor.stallNo})",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),

                              /// STAR
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: Center(
                                  child: Builder(
                                    builder: (_) {
                                      final role = controller.getRole();

                                      bool isFav = false;

                                      /// VISITOR
                                      if (role == 'visitor') {
                                        isFav = favController.visitorFavoriteIds
                                            .contains(exhibitor.inid);
                                      }
                                      /// EXHIBITOR
                                      else if (role == 'exhibitor') {
                                        isFav = favController
                                            .exhibitorFavoriteIds
                                            .contains(exhibitor.inid);
                                      }

                                      return IconButton(
                                        onPressed: () async {
                                          /// NOT LOGGED IN
                                          if (!controller.isLoggedIn()) {
                                            Get.toNamed(
                                              AppRoutes.multiplelogin,
                                            );

                                            return;
                                          }

                                          /// VISITOR
                                          if (role == 'visitor') {
                                            await favController
                                                .toggleVisitorFavorite(
                                                  exhibitor.inid,
                                                );
                                          }
                                          /// EXHIBITOR
                                          else if (role == 'exhibitor') {
                                            await favController
                                                .toggleExhibitorFavorite(
                                                  exhibitor.inid,
                                                );
                                          }
                                        },

                                        padding: EdgeInsets.zero,

                                        constraints: const BoxConstraints(),

                                        icon: Icon(
                                          Icons.star,

                                          size: 30,

                                          color: isFav
                                              ? Colors.yellow
                                              : Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              const Icon(Icons.arrow_forward_ios, size: 20),
                            ],
                          ),
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
