import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/auth_token.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/exhibitorlists.dart';
import 'package:elecrama/data/model/exhibitormodel.dart';
import 'package:elecrama/data/model/visitormodel.dart';
import 'package:elecrama/data/repositories/cache_service.dart';
import 'package:elecrama/data/repositories/network_service.dart';

class AuthService {
  final Dio _dio = DioClient.dio;
  final CacheService _cache = CacheService();

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
      print("LOGIN RESPONSE");
      print(response.data);
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

  //exhibitor login
  Future<Response> exhibitorLogin({required String userId}) async {
    final response = await _dio.get(
      ApiConstants.exhibitorLogin,
      queryParameters: {"EmailId": userId},
      options: Options(
        validateStatus: (_) => true,
        headers: {'Authorization': 'Bearer ${AuthToken.token}'},
      ),
    );
    return response;
  }

  //exhibitor details
  Future<ExhibitorRecord?> fetchExhibitorDetails(String email) async {
    try {
      final response = await _dio.get(
        ApiConstants.exhibitorLogin,
        queryParameters: {"EmailId": email.trim()},
        options: Options(
          validateStatus: (_) => true,
          headers: {'Authorization': 'Bearer ${AuthToken.token}'},
        ),
      );

      final model = ExhibitorDetails.fromJson(response.data);

      if (model.records != null && model.records!.isNotEmpty) {
        return model.records!.first;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  //otp generation
  Future<Response> generateOtp(String email) async {
    try {
      final response = await _dio.get(
        ApiConstants.otpgeneration,
        queryParameters: {"EmailId": email},
      );

      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //exhibitorlist
  Future<List<ExhibitorLists>> fetchExhibitorLists({
    String searchText = "",
  }) async {
    try {
      final isOnline = await NetworkService.isConnected();

      // Only cache full exhibitor list
      final bool shouldUseCache = searchText.isEmpty;

      if (isOnline) {
        final response = await _dio.get(
          ApiConstants.exhibitorlist,
          options: Options(
            responseType: ResponseType.plain,
            headers: {
              "Accept": "application/json",
              "User-Agent": "Mozilla/5.0",
            },
          ),
          queryParameters: {
            "SearchText": searchText,
            "VisitorID": 0,
            "blVisitor": 1,
            "Category": "",
            "Hall": "",
            "Page": 1,
            "country": "",
          },
        );

        if (response.data == null || response.data.toString().trim().isEmpty) {
          return [];
        }

        // Save only master list
        if (shouldUseCache) {
          _cache.save('exhibitor_list', response.data);
        }

        final List<dynamic> data = jsonDecode(response.data);

        return data.map((e) => ExhibitorLists.fromJson(e)).toList();
      }

      // OFFLINE MODE
      final cachedData = _cache.get('exhibitor_list');

      if (cachedData != null) {
        final List<dynamic> data = jsonDecode(cachedData);

        List<ExhibitorLists> exhibitors = data
            .map((e) => ExhibitorLists.fromJson(e))
            .toList();

        // Offline Search
        if (searchText.isNotEmpty) {
          exhibitors = exhibitors.where((item) {
            return (item.companyName).toLowerCase().contains(
              searchText.toLowerCase(),
            );
          }).toList();
        }

        return exhibitors;
      }

      return [];
    } catch (e) {
      // Fallback to cache if API fails

      final cachedData = _cache.get('exhibitor_list');

      if (cachedData != null) {
        final List<dynamic> data = jsonDecode(cachedData);

        return data.map((e) => ExhibitorLists.fromJson(e)).toList();
      }

      throw Exception("error fetching exhibitorlist $e");
    }
  }
}
