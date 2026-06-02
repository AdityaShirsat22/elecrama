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
                    "Request Meetings",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (meetcontroller.groupedMeetings.isEmpty) {
                return const Center(child: Text("No Meetings Found"));
              }

              return ListView.builder(
                itemCount: meetcontroller.groupedMeetings.keys.length,
                itemBuilder: (context, index) {
                  String date = meetcontroller.groupedMeetings.keys.elementAt(
                    index,
                  );

                  List<VisitorMeetingModel> meetings =
                      meetcontroller.groupedMeetings[date] ?? [];

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

  Widget buildMeetingCard(VisitorMeetingModel meeting) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
