import 'package:elecrama/data/model/exhibitormeetingmodel.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/widgets/common_appbar.dart';
import 'package:elecrama/view_model/controller/meetingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorMeetings extends StatefulWidget {
  const ExhibitorMeetings({super.key});

  @override
  State<ExhibitorMeetings> createState() => _ExhibitorMeetingState();
}

class _ExhibitorMeetingState extends State<ExhibitorMeetings> {
  final Meetingcontroller meetcontroller = Get.find<Meetingcontroller>();

  @override
  void initState() {
    super.initState();
    meetcontroller.getExhibitorMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
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
              if (meetcontroller.groupedExhibitorMeetings.isEmpty) {
                return const Center(child: Text("No Meetings Found"));
              }

              return ListView.builder(
                itemCount: meetcontroller.groupedExhibitorMeetings.keys.length,
                itemBuilder: (context, index) {
                  String date = meetcontroller.groupedExhibitorMeetings.keys
                      .elementAt(index);

                  List<ExhibitorMeetingModel> meetings =
                      meetcontroller.groupedExhibitorMeetings[date] ?? [];

                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),

                      title: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      iconColor: Colors.blue,
                      collapsedIconColor: Colors.black,

                      children: meetings
                          .map((meeting) => buildMeetingCard(meeting))
                          .toList(),
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

  Widget buildMeetingCard(ExhibitorMeetingModel meeting) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meeting.visitorName?.trim() ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            meeting.organisation ?? '',
            style: const TextStyle(fontSize: 16),
          ),

          Text(
            meeting.designation ?? '',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 4),

          Text(meeting.meetingdate ?? ''),

          Text("Time : ${meeting.meetingTime}"),

          // const SizedBox(height: 5),

          // const Text(
          //   "Request is in Approval",
          //   style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          // ),
          const Divider(),
        ],
      ),
    );
  }
}
