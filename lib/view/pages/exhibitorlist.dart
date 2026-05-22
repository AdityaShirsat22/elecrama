import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorList extends StatefulWidget {
  const ExhibitorList({super.key});

  @override
  State<ExhibitorList> createState() => _ExhibitorListState();
}

class _ExhibitorListState extends State<ExhibitorList> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.getExhitorsList();
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

        if (exhibitorLists.isEmpty) {
          return const Center(child: Text("No Exhibitors Found"));
        }

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
                        "${exhibitorLists.length} / ${exhibitorLists.length}",
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
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: "Search by Company / Products Name",
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

                    return Padding(
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

                          Icon(
                            Icons.star,
                            color: Colors.grey.shade400,
                            size: 35,
                          ),

                          const SizedBox(width: 10),

                          /// ARROW
                          const Icon(Icons.arrow_forward_ios, size: 20),
                        ],
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
