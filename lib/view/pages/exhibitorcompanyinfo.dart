import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/data/model/exhibitorlists.dart';
import 'package:elecrama/data/model/visitor_fav_model.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elecrama/data/model/exhibitor_fav_model.dart';

class ExhibitorCompanyInfo extends StatefulWidget {
  const ExhibitorCompanyInfo({super.key});

  @override
  State<ExhibitorCompanyInfo> createState() =>
      _ExhibitorCompanyInfoScreenState();
}

class _ExhibitorCompanyInfoScreenState extends State<ExhibitorCompanyInfo> {
  final favController = Get.find<FavoriteController>();
  final controller = Get.find<AuthController>();
  bool aboutExpanded = false;
  bool productExpanded = false;
  bool mediaExpanded = false;

  ExhibitorLists _resolveExhibitor(dynamic argument) {
    /// EXHIBITOR LIST
    if (argument is ExhibitorLists) {
      return argument;
    }

    /// VISITOR FAVORITE
    if (argument is VisitorFavoriteModel) {
      final favorite = argument;

      return ExhibitorLists(
        inid: favorite.exhibitorId,

        guid: favorite.guid,

        exhibitorType: '',

        companyName: favorite.companyName,

        txtConPerson: favorite.contactPerson,

        txtConPreDesi: favorite.designation,

        address: favorite.address,

        txtTelNo: '',

        txtMobile: favorite.mobile,

        email: favorite.email,

        stallNo: favorite.stallNo,

        hallNo: favorite.hallNo,

        txtUserEmailId: '',

        txtUserId: '',

        memType: '',

        chairmanname: '',

        chairmandesig: '',

        txtcountry: favorite.country,

        ddlRegion: '',

        ddlState: '',

        ddlCity: '',

        txtPin: '',

        productList: favorite.productList,

        productListCatId: '',

        visitorLikes: 0,

        hallId: 0,

        stStallId: '',

        pavilion: '',
      );
    }

    /// EXHIBITOR FAVORITE
    if (argument is ExhibitorFavouriteModel) {
      final favorite = argument;

      return ExhibitorLists(
        inid: favorite.inid,

        guid: favorite.guid,

        exhibitorType: '',

        companyName: favorite.txtComName,

        txtConPerson: favorite.contactPerson,

        txtConPreDesi: favorite.pcDesignation,

        address: favorite.address,

        txtTelNo: '',

        txtMobile: favorite.pcMobile,

        email: favorite.pcEmail,

        stallNo: favorite.stallNo,

        hallNo: favorite.hallNo,

        txtUserEmailId: '',

        txtUserId: favorite.txtUserId,

        memType: '',

        chairmanname: '',

        chairmandesig: '',

        txtcountry: favorite.txtcountry,

        ddlRegion: '',

        ddlState: favorite.state,

        ddlCity: favorite.city,

        txtPin: favorite.pin,

        productList: favorite.productList,

        productListCatId: favorite.productCatIds,

        visitorLikes: favorite.visitorLikes,

        hallId: favorite.hallId,

        stStallId: favorite.stStallId,

        pavilion: '',
      );
    }
    throw ArgumentError(
      'Unsupported exhibitor argument: '
      '$argument',
    );
  }

  @override
  void initState() {
    super.initState();
    favController.getVisitorFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    final exhibitor = _resolveExhibitor(Get.arguments);

    return Scaffold(
      appBar: appbar,

      body: Obx(() {
        favController.visitorFavoriteIds.length;
        favController.exhibitorFavoriteIds.length;
        return SingleChildScrollView(
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
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
                    /// STAR
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Builder(
                          builder: (_) {
                            final role = controller.getRole();

                            bool isFav = false;

                            /// VISITOR
                            if (role == 'visitor') {
                              isFav = favController.visitorFavoriteIds.contains(
                                exhibitor.inid,
                              );
                            }
                            /// EXHIBITOR
                            else if (role == 'exhibitor') {
                              isFav = favController.exhibitorFavoriteIds
                                  .contains(exhibitor.inid);
                            }

                            return IconButton(
                              onPressed: () async {
                                /// NOT LOGGED IN
                                if (!controller.isLoggedIn()) {
                                  Get.toNamed(AppRoutes.multiplelogin);

                                  return;
                                }

                                /// VISITOR
                                if (role == 'visitor') {
                                  await favController.toggleVisitorFavorite(
                                    exhibitor.inid,
                                  );
                                }
                                /// EXHIBITOR
                                else if (role == 'exhibitor') {
                                  await favController.toggleExhibitorFavorite(
                                    exhibitor.inid,
                                  );
                                }
                              },

                              padding: EdgeInsets.zero,

                              constraints: const BoxConstraints(),

                              icon: Icon(
                                Icons.star,

                                size: 30,

                                color: isFav ? Colors.yellow : Colors.grey,
                              ),
                            );
                          },
                        ),
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
        );
      }),
    );
  }
}
