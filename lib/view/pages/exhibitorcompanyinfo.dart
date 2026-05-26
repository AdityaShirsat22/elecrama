import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/data/model/exhibitorlists.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/visitior_fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorCompanyInfo extends StatefulWidget {
  ExhibitorCompanyInfo({super.key});

  final ExhibitorLists exhibitor = Get.arguments;

  @override
  State<ExhibitorCompanyInfo> createState() =>
      _ExhibitorCompanyInfoScreenState();
}

class _ExhibitorCompanyInfoScreenState extends State<ExhibitorCompanyInfo> {
  final favController = Get.find<FavoriteController>();
  bool aboutExpanded = false;
  bool productExpanded = false;
  bool mediaExpanded = false;

  @override
  void initState() {
    super.initState();
    favController.getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    final exhibitor = widget.exhibitor;

    return Scaffold(
      appBar: appbar,

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// TOP BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              child: Row(
                children: [
                  /// COMPANY INFO
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},

                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: const Center(
                          child: Text(
                            "Company Info",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// REQUEST MEETING
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        /// REQUEST MEETING CLICK
                      },

                      child: Container(
                        height: 40,

                        decoration: BoxDecoration(
                          border: Border.all(color: orange),

                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: const Center(
                          child: Text(
                            "Request Meeting",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  /// SHARE
                  GestureDetector(
                    onTap: () {
                      /// SHARE CLICK
                    },

                    child: const Icon(
                      Icons.share,
                      color: Colors.blueGrey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// COMPANY NAME
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(
                      exhibitor.companyName,

                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  //const SizedBox(width: 10),

                  /// QR
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          /// QR CLICK
                        },
                        child: const Icon(Icons.qr_code, size: 30),
                      ),
                    ),
                  ),

                  /// STAR
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: Center(
                      child: Obx(() {
                        final isFav = favController.favoriteIds.contains(
                          exhibitor.inid,
                        );

                        return IconButton(
                          onPressed: () async {
                            await favController.toggleFavorite(exhibitor.inid);
                          },
                          icon: Icon(
                            Icons.star,
                            color: isFav ? Colors.yellow : Colors.grey.shade400,
                            size: 35,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// HALL BOX
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  /// HALL CLICK
                },

                child: Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(color: Colors.red.shade100),

                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "( ${exhibitor.hallNo} )  STALL : ${exhibitor.stallNo}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(),

            /// ABOUT COMPANY
            ExpansionTile(
              title: const Text(
                "About Company",
                style: TextStyle(fontSize: 20),
              ),

              childrenPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),

              children: [
                Align(
                  alignment: Alignment.centerLeft,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        exhibitor.productList,
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Contact Detail",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),
                      Text(
                        "Email : ${exhibitor.email}",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Address : \n${exhibitor.address}",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Country : ${exhibitor.txtcountry}",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Contact Person : ${exhibitor.txtConPerson}",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Designation : ${exhibitor.txtConPreDesi}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// PRODUCT CATEGORY
            ExpansionTile(
              title: const Text(
                "Product Categories",
                style: TextStyle(fontSize: 20),
              ),

              childrenPadding: const EdgeInsets.fromLTRB(20, 5, 10, 15),

              children: [
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    exhibitor.productList,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),

            /// DOWNLOAD & MEDIA
            ExpansionTile(
              title: const Text(
                "Download & Media",
                style: TextStyle(fontSize: 20),
              ),

              childrenPadding: const EdgeInsets.fromLTRB(20, 5, 10, 15),

              children: const [
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "No Media Available",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
