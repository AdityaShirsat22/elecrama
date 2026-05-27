import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/exhibitor_fav_model.dart';
import 'package:elecrama/data/model/visitor_fav_model.dart';

class FavoriteService {
  final Dio _dio = DioClient.dio;

  Future<List<VisitorFavoriteModel>> getVisitorFavoriteList({
    required int visitorId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.visitorfavlist,
        queryParameters: {
          'VisitorId': visitorId,
          'Country': '',
          'HallNo': '',
          'OrderBy': '',
        },
        options: Options(responseType: ResponseType.plain),
      );
      final body = response.data.toString().trim();
      if (body.isEmpty) {
        return [];
      }
      final decoded = jsonDecode(body);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .map(
            (item) =>
                VisitorFavoriteModel.fromJson(item as Map<String, dynamic>),
          )
          .toList()
          .cast<VisitorFavoriteModel>();
    } catch (e) {
      throw Exception('Favorite List Error : $e');
    }
  }

  Future<bool> toggleVisitorFavorite({
    required int exhibitorId,
    required int visitorId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.visitorfavlistadddelete,
        queryParameters: {'ExhibitorId': exhibitorId, 'VisitorId': visitorId},
        options: Options(responseType: ResponseType.plain),
      );
      final body = response.data.toString().trim();
      if (body.isEmpty) {
        return false;
      }
      final decoded = jsonDecode(body);
      /// FIXED
      if (decoded is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Toggle Favorite Error : $e');
    }
  }

//exhibitorlist
  Future<List<ExhibitorFavouriteModel>> getExhibitorFavoriteList({
    required int exhibitorUserId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.exhibitorfavlist,
        queryParameters: {
          'ExhibitorUserId': exhibitorUserId,
          'Country': '',
          'HallNo': '',
          'OrderBy': '',
        },
        options: Options(responseType: ResponseType.plain),
      );
      final body = response.data.toString().trim();
      if (body.isEmpty) {
        return [];
      }
      final decoded = jsonDecode(body);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .map(
            (item) =>
                ExhibitorFavouriteModel.fromJson(item as Map<String, dynamic>),
          )
          .toList()
          .cast<ExhibitorFavouriteModel>();
    } catch (e) {
      throw Exception('Favorite List Error : $e');
    }
  }

  Future<bool> toggleExhibitorFavorite({
    required int exhibitorId,
    required int exhibitorUserId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.exhibitorfavlistadddelete,
        queryParameters: {'ExhibitorId': exhibitorId, 'ExhibitorUserId': exhibitorUserId},
        options: Options(responseType: ResponseType.plain),
      );
      final body = response.data.toString().trim();
      if (body.isEmpty) {
        return false;
      }
      final decoded = jsonDecode(body);
      /// FIXED
      if (decoded is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Toggle Favorite Error : $e');
    }
  }
}
