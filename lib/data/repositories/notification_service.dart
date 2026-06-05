import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/notificationmodel.dart';

class NotificationService {
  final Dio _dio = DioClient.dio;

  Future<List<NotificationModel>> getVisitorNotifications(int visitorId) async {
    final response = await _dio.get(
      ApiConstants.getnotificationvisitor,
      queryParameters: {"VisitorID": visitorId},
    );

    return (response.data as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }

  Future<bool> updateVisitorNotificationStatus({
    required int visitorId,
    required int status,
  }) async {
    final response = await _dio.post(
      ApiConstants.updatevisitornotifications,
      queryParameters: {"VisitorID": visitorId, "NotificationIdStatus": status},
    );

    return response.statusCode == 200;
  }

  Future<bool> updateVisitorMailNotificationStatus({
    required int visitorId,
    required int status,
  }) async {
    final response = await _dio.post(
      ApiConstants.updatevisitormailnotifications,
      queryParameters: {"VisitorID": visitorId, "NotificationIdStatus": status},
    );

    return response.statusCode == 200;
  }


  Future<List<NotificationModel>> getExhibitorNotifications(
      int exhibitorId) async {
    final response = await _dio.get(
      ApiConstants.getnotificationexhibitor,
      queryParameters: {
        "ExhibitorID": exhibitorId,
      },
    );

    return (response.data as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }

  Future<bool> updateExhibitorNotificationStatus({
    required int exhibitorId,
    required int status,
  }) async {
    final response = await _dio.post(
      ApiConstants.updateexhibitornotifications,
      queryParameters: {
        "ExhibitorID": exhibitorId,
        "NotificationIdStatus": status,
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> updateExhibitorMailNotificationStatus({
    required int exhibitorId,
    required int status,
  }) async {
    final response = await _dio.post(
      ApiConstants.updateexhibitormailnotifications,
      queryParameters: {
        "ExhibitorID": exhibitorId,
        "NotificationIdStatus": status,
      },
    );

    return response.statusCode == 200;
  }
}
