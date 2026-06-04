import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/data/model/exhibitorlists.dart';
import 'package:elecrama/data/model/visitor_fav_model.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/fav_controller.dart';
import 'package:elecrama/view_model/controller/meetingController.dart';
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
  bool showRequestMeeting = false;
  TextEditingController remarkController = TextEditingController();
  late final Meetingcontroller meetingController;
  String? selectedDate;
  String? selectedMeetingPerson;
  String? selectedTime;

  int remarkCount = 0;

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
        txtUserId: favorite.txtUserID,
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
    meetingController = Get.find<Meetingcontroller>();

    final exhibitor = _resolveExhibitor(Get.arguments);

    print("Role = ${controller.getRole()}");

    print("TxtUserID : ${exhibitor.txtUserId}");

    if (exhibitor.txtUserId.isNotEmpty) {
      meetingController.getMeetingPersons(exhibitor.txtUserId);
    }
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
                        onTap: () {
                          setState(() {
                            showRequestMeeting = false;
                          });
                        },

                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: !showRequestMeeting ? orange : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Center(
                            child: Text(
                              "Company Info",
                              style: TextStyle(
                                color: !showRequestMeeting
                                    ? Colors.white
                                    : Colors.black,
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
                          setState(() {
                            showRequestMeeting = true;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: orange),
                            color: showRequestMeeting ? orange : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Center(
                            child: Text(
                              "Request Meeting",
                              style: TextStyle(
                                fontSize: 16,
                                color: showRequestMeeting
                                    ? Colors.white
                                    : Colors.black,
                              ),
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

              showRequestMeeting
                  ? buildRequestMeetingForm()
                  : buildCompanyInfo(exhibitor),
            ],
          ),
        );
      }),
    );
  }

  Widget buildRequestMeetingForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Request Meeting",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// DATE
          Obx(
            () => DropdownButtonFormField<String>(
              value: meetingController.exhibitionDates.isEmpty
                  ? null
                  : selectedDate,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text("Select Date"),
              items: meetingController.exhibitionDates.map((date) {
                return DropdownMenuItem(value: date, child: Text(date));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDate = value;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          /// PERSON
          Obx(() {
            if (meetingController.isLoadingMeetingPersons.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!meetingController.hasMeetingPersons.value) {
              return TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "No meeting persons available",
                ),
              );
            }

            return DropdownButtonFormField<String>(
              isExpanded: true,
              value: selectedMeetingPerson,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text("Select Meeting Person"),
              items: meetingController.meetingPersons.map((person) {
                return DropdownMenuItem<String>(
                  value: person.id.toString(),
                  child: Text(
                    "${person.staffName} (${person.designation ?? ''})",
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMeetingPerson = value;
                });
              },
            );
          }),

          const SizedBox(height: 15),

          /// TIME
          DropdownButtonFormField<String>(
            value: selectedTime,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            hint: const Text("Select time"),
            items: meetingController.timeSlots.map((time) {
              return DropdownMenuItem(value: time, child: Text(time));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedTime = value;
              });
            },
          ),

          const SizedBox(height: 15),

          /// REMARK
          TextField(
            controller: remarkController,
            maxLength: 150,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Enter Note",
              border: OutlineInputBorder(),
              counterText: '',
            ),
            onChanged: (value) {
              setState(() {
                remarkCount = value.length;
              });
            },
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$remarkCount/150",
              style: const TextStyle(fontSize: 14),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () async {
                final exhibitor = _resolveExhibitor(Get.arguments);

                if (selectedDate == null) {
                  Get.snackbar("Validation", "Please select date");
                  return;
                }

                if (selectedMeetingPerson == null) {
                  Get.snackbar("Validation", "Please select meeting person");
                  return;
                }

                if (selectedTime == null) {
                  Get.snackbar("Validation", "Please select time");
                  return;
                }

                final success = await meetingController.saveMeeting(
                  exhibitorId: exhibitor.inid,
                  meetPersonId: selectedMeetingPerson!,
                  meetingDate: selectedDate!,
                  selectedTime: selectedTime!,
                  role: controller.getRole(),
                );
                if (success) {
                  showMeetingSuccessDialog();
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompanyInfo(ExhibitorLists exhibitor) {
    return Column(
      children: [
        /// ABOUT COMPANY
        ExpansionTile(
          title: const Text("About Company", style: TextStyle(fontSize: 20)),

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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
          title: const Text("Download & Media", style: TextStyle(fontSize: 20)),

          childrenPadding: const EdgeInsets.fromLTRB(20, 5, 10, 15),

          children: const [
            Align(
              alignment: Alignment.centerLeft,

              child: Text("No Media Available", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ],
    );
  }

  void showMeetingSuccessDialog() {
    Get.dialog(
      
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Your Meeting Request has been submitted",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 20),

            const Text(
              "Please select an option from below",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Get.back();

                  final role = controller.getRole();

                  if (role == 'visitor') {
                    Get.toNamed(AppRoutes.visitormeetings);
                  } else {
                    Get.toNamed(AppRoutes.exhibitormeetings);
                  }
                },
                child: const Text(
                  "GO TO MY MEETINGS",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Get.back();

                  // Back to previous screen
                  Get.back();
                },
                child: const Text(
                  "GO BACK TO EXHIBITOR LIST",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
