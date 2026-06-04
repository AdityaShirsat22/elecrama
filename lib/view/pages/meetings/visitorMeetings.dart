import 'package:elecrama/core/colors_theme.dart';
import 'package:elecrama/data/model/visitormeetingmodel.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/meetingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitorMeetings extends StatefulWidget {
  const VisitorMeetings({super.key});

  @override
  State<VisitorMeetings> createState() => _VisitorMeetingsState();
}

class _VisitorMeetingsState extends State<VisitorMeetings> {
  final Meetingcontroller meetcontroller = Get.find<Meetingcontroller>();

  @override
  void initState() {
    super.initState();
    meetcontroller.getVisitorMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          await meetcontroller.getVisitorMeetings();
        },
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Meetings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.exhibitorlist);
                  },
                  child: Text(
                    "+ Request Meetings",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (meetcontroller.visitorGroupedMeetings.isEmpty) {
                return const Center(child: Text("No Meetings Found"));
              }

              return ListView.builder(
                itemCount: meetcontroller.visitorGroupedMeetings.keys.length,
                itemBuilder: (context, index) {
                  String date = meetcontroller.visitorGroupedMeetings.keys
                      .elementAt(index);

                  List<VisitorMeetingModel> meetings =
                      meetcontroller.visitorGroupedMeetings[date] ?? [];

                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),

                      //childrenPadding: EdgeInsets.zero,
                      title: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      iconColor: Colors.blue,
                      collapsedIconColor: Colors.black,

                      children: meetings.map((meeting) {
                        return Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: buildMeetingCard(meeting),
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildMeetingCard(VisitorMeetingModel meeting) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meeting.txtConPerson?.trim() ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(meeting.txtComName ?? '', style: const TextStyle(fontSize: 16)),

          Text(
            meeting.txtConDesi ?? '',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 4),

          Text(meeting.meetingdate ?? ''),

          Text("Time : ${meeting.meetingTime}"),

          const SizedBox(height: 8),

          buildVisitorMeetingStatus(meeting),
        ],
      ),
    );
  }

  Widget buildVisitorMeetingStatus(VisitorMeetingModel meeting) {
    if (meeting.blExhibitorStatus == 0) {
      return Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Request is in Approval",
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),

          const SizedBox(height: 10),

          // SizedBox(
          //   width: 120,
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       final success = await meetcontroller.cancelVisitorMeeting(
          //         meeting.meetingId ?? 0,
          //       );

          //       if (success) {
          //         await meetcontroller.getVisitorMeetings();
          //       }
          //     },
          //     child: const Text("Cancel"),
          //   ),
          // ),
        ],
      );
    }

    if (meeting.blExhibitorStatus == 1) {
      return const Text(
        "Accepted",
        style: TextStyle(
          color: Colors.green,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    if (meeting.blExhibitorStatus == 2) {
      return const Text(
        "Cancelled",
        style: TextStyle(color: Colors.red, fontSize: 18),
      );
    }

    return const SizedBox();
  }
}
