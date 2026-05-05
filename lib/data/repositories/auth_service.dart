import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/auth_token.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/visitorModel.dart';

class AuthService {
  final Dio _dio = DioClient.dio;

  //visitorlogin
  Future<Response> visitorLogin({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.visitorLogin,
        queryParameters: {
          "UserID": userId,
          "password": password,
          "DeviceId":
              "caVZ55tcTl2Sa8xNkV7Nnu:APA91bEUuvECtiPU_Ivyve-gKzPzaPdvXTiYQP5tLYngEONBXmKEYfNCCSyDKzOv82lU0_hELkL2rNa3yxPuwyL8xKetNduNlCdqCu-RbCFP4DBNLq2bGWQ&blIOS=0",
          //"blIOS": "false",
        },
        options: Options(
          validateStatus: (_) => true,
          headers: {'Authorization': 'Bearer ${AuthToken.token}'},
        ),
      );
      return response;
    } catch (e) {
      if (e is DioException && e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<VisitorRecord?> fetchVisitorDetails(
    String userId,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.visitorLogin,
        queryParameters: {
          "UserID": userId.trim(),
          "password": password.trim(),
          "DeviceId":
              "caVZ55tcTl2Sa8xNkV7Nnu:APA91bEUuvECtiPU_Ivyve-gKzPzaPdvXTiYQP5tLYngEONBXmKEYfNCCSyDKzOv82lU0_hELkL2rNa3yxPuwyL8xKetNduNlCdqCu-RbCFP4DBNLq2bGWQ&blIOS=0",
          //"blIOS": "false",
        },
        options: Options(
          validateStatus: (_) => true,
          headers: {'Authorization': 'Bearer ${AuthToken.token}'},
        ),
      );

      print('API Response: ${response.data}');
      print('Response Code: ${response.statusCode}');

      // Parse the response as a VisitorRecord directly (not wrapped in a model)
      final visitorRecord = VisitorRecord.fromJson(response.data);

      print('Parsed VisitorRecord - Email: ${visitorRecord.emailId}');

      if (visitorRecord.emailId != null && visitorRecord.emailId!.isNotEmpty) {
        return visitorRecord;
      }

      return null;
    } catch (e) {
      print('Error fetching visitor details: $e');
      return null;
    }
  }
}
