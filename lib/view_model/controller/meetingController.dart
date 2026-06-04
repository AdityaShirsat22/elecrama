import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/exhibitorconnectmodel.dart';
import 'package:elecrama/data/model/exhibitormeetingmodel.dart';
import 'package:elecrama/data/model/meetingpersonmodel.dart';
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

  RxList<ExhibitorConnectModel> meetingPersons = <ExhibitorConnectModel>[].obs;
  RxBool hasMeetingPersons = false.obs;
  RxBool isLoadingMeetingPersons = false.obs;

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

  Future<void> getMeetingPersons(String exhibitorUserId) async {
    try {
      isLoadingMeetingPersons.value = true;

      final response = await _dio.get(
        ApiConstants.getexhibitorprofile,
        queryParameters: {'ExhibitorId': exhibitorUserId},
      );

      meetingPersons.clear();
      hasMeetingPersons.value = false;

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data is List &&
          response.data.isNotEmpty) {
        final profile = MeetingPersonModel.fromJson(response.data.first);

        if (profile.exhibitorConnect != null &&
            profile.exhibitorConnect!.isNotEmpty) {
          final List<dynamic> decoded = jsonDecode(profile.exhibitorConnect!);

          meetingPersons.value = decoded
              .map((e) => ExhibitorConnectModel.fromJson(e))
              .toList();

          hasMeetingPersons.value = meetingPersons.isNotEmpty;
        }
      }

      print("Meeting Persons Count : ${meetingPersons.length}");

      for (var person in meetingPersons) {
        print("${person.id} - ${person.staffName} - ${person.designation}");
      }
    } catch (e) {
      debugPrint("Meeting Person Error : $e");

      meetingPersons.clear();
      hasMeetingPersons.value = false;
    } finally {
      isLoadingMeetingPersons.value = false;
    }
  }

  Map<String, String> getHourMinute(String time) {
    final parts = time.split(' ');
    final timePart = parts[0];
    final period = parts[1];
    int hour = int.parse(timePart.split(':')[0]);
    final minute = timePart.split(':')[1];
    if (period == 'PM' && hour != 12) {
      hour += 12;
    }
    if (period == 'AM' && hour == 12) {
      hour = 0;
    }
    return {'hour': hour.toString(), 'minute': minute};
  }

  Future<bool> saveMeeting({
    required int exhibitorId,
    required String meetPersonId,
    required String meetingDate,
    required String selectedTime,
    required String role,
  }) async {
    try {
      final timeData = getHourMinute(selectedTime);
      int visitorId = 0;
      int createdBy = 0;
      if (role == 'visitor') {
        visitorId = hiveService.getVisitorinId();
        createdBy = 0;
      } else {
        visitorId = hiveService.getExhibitorinId();
        createdBy = 1;
      }
      print("VisitorId : $visitorId");
      print("ExhibitorId : $exhibitorId");
      print("MeetPersonId : $meetPersonId");
      print("MeetingDate : $meetingDate");
      print("MeetingHr : ${timeData['hour']}");
      print("MeetingMM : ${timeData['minute']}");
      print("CreatedBy : $createdBy");
      final response = await _dio.post(
        ApiConstants.saveVisitorMeeting,
        queryParameters: {
          "VisitorId": visitorId,
          "ExhibitorId": exhibitorId,
          "MeetPersonId": meetPersonId,
          "Meetingdate": meetingDate,
          "MeetingHr": timeData['hour'],
          "MeetingMM": timeData['minute'],
          "CreatedBy": createdBy,
        },
      );
      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        final result = response.data.first;

        if (result["Code"] == "1") {
          if (role == 'visitor') {
            await getVisitorMeetings();
          } else {
            await getExhibitorMeetings();
          }

          return true;
        }
      }

      return false;
    } catch (e) {
      debugPrint("Save Meeting Error : $e");

      Get.snackbar("Error", "Failed to save meeting");

      return false;
    }
  }

  Future<bool> acceptMeeting(int meetingId) async {
    try {
      final response = await _dio.post(
        ApiConstants.acceptExhibitorMeeting,
        queryParameters: {"MeetingId": meetingId},
      );

      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        return response.data.first["Code"] == "1";
      }

      return false;
    } catch (e) {
      debugPrint("Accept Meeting Error : $e");
      return false;
    }
  }

  Future<bool> cancelExhibitorMeeting(int meetingId) async {
    try {
      final response = await _dio.post(
        ApiConstants.cancelExhibitorMeeting,
        queryParameters: {"MeetingId": meetingId},
      );

      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        return response.data.first["Code"] == "1";
      }

      return false;
    } catch (e) {
      debugPrint("Cancel Exhibitor Meeting Error : $e");
      return false;
    }
  }

  Future<bool> cancelVisitorMeeting(int meetingId) async {
    try {
      final response = await _dio.post(
        ApiConstants.cancelVisitorMeeting,
        queryParameters: {"MeetingId": meetingId},
      );

      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        return response.data.first["Code"] == "1";
      }

      return false;
    } catch (e) {
      debugPrint("Cancel Visitor Meeting Error : $e");
      return false;
    }
  }
}
