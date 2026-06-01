import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Meetingcontroller extends GetxController {
  RxList<String> exhibitionDates = <String>[].obs;

  RxString selectedDate = ''.obs;
  RxString selectedMeetingPerson = ''.obs;
  RxString selectedTime = ''.obs;

  TextEditingController remarkController = TextEditingController();

  RxInt remarkCount = 0.obs;
  final Dio _dio = DioClient.dio;

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
}
