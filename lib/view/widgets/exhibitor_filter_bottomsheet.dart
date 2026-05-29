import 'package:elecrama/view_model/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorFilterBottomSheet extends StatefulWidget {
  const ExhibitorFilterBottomSheet({super.key});

  @override
  State<ExhibitorFilterBottomSheet> createState() =>
      _ExhibitorFilterBottomSheetState();
}

class _ExhibitorFilterBottomSheetState
    extends State<ExhibitorFilterBottomSheet> {
      
  final controller = Get.find<AuthController>();

  int selectedIndex = 0;

  final searchController = TextEditingController();

  final categories = ['Hall', 'Country', 'Product Categories'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 25),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filter',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                /// LEFT MENU
                Container(
                  width: 120,
                  color: Colors.grey.shade100,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                          color: selectedIndex == index
                              ? Colors.blue.shade100
                              : Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  categories[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),

                              /// COUNT BADGE
                              if (index == 0 &&
                                  controller.selectedHalls.isNotEmpty)
                                badge(controller.selectedHalls.length),

                              if (index == 1 &&
                                  controller.selectedCountries.isNotEmpty)
                                badge(controller.selectedCountries.length),

                              if (index == 2 &&
                                  controller.selectedProductIds.isNotEmpty)
                                badge(controller.selectedProductIds.length),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: buildRightView()),
              ],
            ),
          ),
          SizedBox(height: 10),

          /// BUTTONS
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    controller.applyFilters();
                    Get.back();
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.clearFilters();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget badge(int count) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.green,
      child: Text(
        count.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget buildHallView() {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.hallList.length,
        itemBuilder: (context, index) {
          final item = controller.hallList[index];

          final hallName = item['HallNo'];

          final isSelected = controller.selectedHalls.contains(hallName);

          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              if (value == true) {
                controller.selectedHalls.add(hallName);
              } else {
                controller.selectedHalls.remove(hallName);
              }

              setState(() {});
            },
            title: Text(hallName),
          );
        },
      );
    });
  }

  Widget buildProductCategoryView() {
    final search = searchController.text.toLowerCase();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: searchController,

            onChanged: (_) {
              setState(() {});
            },

            decoration: InputDecoration(
              hintText: 'Search Categories',
              prefixIcon: const Icon(Icons.search),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: controller.productCategoryList.length,

            itemBuilder: (context, index) {
              final item = controller.productCategoryList[index];

              final categoryName = (item['PrCatName'] ?? '').toString();

              final subCategories = (item['SubCategories'] ?? '')
                  .toString()
                  .split(',');

              final subCategoryIds = (item['SubCategoriesId'] ?? '')
                  .toString()
                  .split(',');

              /// CREATE PAIRS
              final pairedList = List.generate(
                subCategories.length,
                (i) => {
                  'name': subCategories[i].trim(),

                  'id': i < subCategoryIds.length
                      ? subCategoryIds[i].trim()
                      : '',
                },
              );

              /// SEARCH
              final filteredList = pairedList.where((sub) {
                return sub['name']!.toLowerCase().contains(search);
              }).toList();

              if (filteredList.isEmpty && search.isNotEmpty) {
                return const SizedBox();
              }

              /// ALL SELECTED
              final allSelected = filteredList.every(
                (sub) => controller.selectedProductIds.contains(sub['id']),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// PARENT CATEGORY
                  CheckboxListTile(
                    value: allSelected,

                    onChanged: (value) {
                      if (value == true) {
                        for (var sub in filteredList) {
                          controller.selectedProductIds.add(sub['id']!);
                        }
                      } else {
                        for (var sub in filteredList) {
                          controller.selectedProductIds.remove(sub['id']);
                        }
                      }

                      setState(() {});
                    },

                    title: Text(
                      categoryName,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  /// SUBCATEGORYS
                  ...filteredList.map((sub) {
                    final isSelected = controller.selectedProductIds.contains(
                      sub['id'],
                    );

                    return Padding(
                      padding: const EdgeInsets.only(left: 25),

                      child: CheckboxListTile(
                        value: isSelected,

                        onChanged: (value) {
                          if (value == true) {
                            controller.selectedProductIds.add(sub['id']!);
                          } else {
                            controller.selectedProductIds.remove(sub['id']);
                          }

                          setState(() {});
                        },

                        title: Text(sub['name']!),
                      ),
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildRightView() {
    if (selectedIndex == 0) {
      return buildHallView();
    }

    if (selectedIndex == 1) {
      return buildCountryView();
    }

    return buildProductCategoryView();
  }

  Widget buildCountryView() {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.countryList.length,
        itemBuilder: (context, index) {
          final item = controller.countryList[index];

          final country = item['Country_Name'];

          final isSelected = controller.selectedCountries.contains(country);

          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              if (value == true) {
                controller.selectedCountries.add(country);
              } else {
                controller.selectedCountries.remove(country);
              }

              setState(() {});
            },
            title: Text(country),
          );
        },
      );
    });
  }
}
