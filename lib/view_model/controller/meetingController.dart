import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/exhibitormeetingmodel.dart';
import 'package:elecrama/data/repositories/hiveservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/visitormeetingmodel.dart';

class Meetingcontroller extends GetxController {
  RxList<String> exhibitionDates = <String>[].obs;

  RxString selectedDate = ''.obs;
  RxString selectedMeetingPerson = ''.obs;
  RxString selectedTime = ''.obs;

  TextEditingController remarkController = TextEditingController();

  RxInt remarkCount = 0.obs;
  final Dio _dio = DioClient.dio;
  final Hiveservice hiveService = Hiveservice();

  final List<String> timeSlots = [
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
  ];

  @override
  void onInit() {
    super.onInit();
    getExhibitionDates();

    print("MeetingController onInit");
    getVisitorMeetings();
  }

  Future<void> getExhibitionDates() async {
    try {
      final response = await _dio.get(ApiConstants.exhibitordates);

      if (response.statusCode == 200) {
        exhibitionDates.clear();

        for (var item in response.data) {
          exhibitionDates.add(item['EventDate']);
        }

        if (exhibitionDates.isNotEmpty) {
          selectedDate.value = exhibitionDates.first;
        }
      }
    } catch (e) {
      debugPrint("Date API Error : $e");
    }
  }

  RxList<VisitorMeetingModel> visitorMeetingList = <VisitorMeetingModel>[].obs;
  RxMap<String, List<VisitorMeetingModel>> visitorGroupedMeetings =
      <String, List<VisitorMeetingModel>>{}.obs;

  void groupVisitorMeetingsByDate() {
    Map<String, List<VisitorMeetingModel>> temp = {};
    for (var meeting in visitorMeetingList) {
      String date = meeting.meetingdate ?? '';
      if (!temp.containsKey(date)) {
        temp[date] = [];
      }
      temp[date]!.add(meeting);
    }
    visitorGroupedMeetings.value = temp;
  }

  Future<void> getVisitorMeetings() async {
    try {
      final visitorinId = hiveService.getVisitorinId();
      print("Visitor InID From Hive = $visitorinId");

      final response = await _dio.get(
        ApiConstants.visitormeetings,
        queryParameters: {
          'VisitorId': visitorinId,
          'Meetingdate': '',
          'Hall': '',
        },
      );

      if (response.statusCode == 200) {
        visitorMeetingList.value = (response.data as List)
            .map((e) => VisitorMeetingModel.fromJson(e))
            .toList();

        groupVisitorMeetingsByDate();

        print(response.data);
        print(visitorMeetingList.length);
        print(visitorGroupedMeetings);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //exhibitor meeting
  RxList<ExhibitorMeetingModel> exhibitorMeetingList =
      <ExhibitorMeetingModel>[].obs;
  RxMap<String, List<ExhibitorMeetingModel>> groupedExhibitorMeetings =
      <String, List<ExhibitorMeetingModel>>{}.obs;

  void groupExhibitorMeetingsByDate() {
    Map<String, List<ExhibitorMeetingModel>> temp = {};
    for (var meeting in exhibitorMeetingList) {
      String date = meeting.meetingdate ?? '';
      if (!temp.containsKey(date)) {
        temp[date] = [];
      }
      temp[date]!.add(meeting);
    }
    groupedExhibitorMeetings.value = temp;
  }

  Future<void> getExhibitorMeetings() async {
    try {
      final exhibitorinId = hiveService.getExhibitorinId();
      print("Exhibitor InID From Hive = $exhibitorinId");

      final response = await _dio.get(
        ApiConstants.exhibitormeetings,
        queryParameters: {'ExhibitorUserId': exhibitorinId, 'Meetingdate': ''},
      );

      if (response.statusCode == 200) {
        exhibitorMeetingList.value = (response.data as List)
            .map((e) => ExhibitorMeetingModel.fromJson(e))
            .toList();

        groupExhibitorMeetingsByDate();

        print(response.data);
        print(exhibitorMeetingList.length);
        print(groupedExhibitorMeetings);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
