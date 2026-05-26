import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/visitior_fav_controller.dart';
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
    controller.getExhitorsList();
    favController.getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Obx(() {
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

                  separatorBuilder: (_, __) => const Divider(),

                  itemBuilder: (context, index) {
                    final exhibitor = exhibitorLists[index];

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
                                    "(${exhibitor.hallNo}    STALL : ${exhibitor.stallNo})",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                            Obx(() {
                              final isFav = favController.favoriteIds.contains(
                                exhibitor.inid,
                              );

                              return IconButton(
                                onPressed: () async {
                                  await favController.toggleFavorite(
                                    exhibitor.inid,
                                  );
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: isFav
                                      ? Colors.yellow
                                      : Colors.grey.shade400,
                                  size: 35,
                                ),
                              );
                            }),

                            const SizedBox(width: 10),

                            /// ARROW
                            const Icon(Icons.arrow_forward_ios, size: 20),
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
