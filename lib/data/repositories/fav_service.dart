import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/exhibitor_fav_model.dart';
import 'package:elecrama/data/model/visitor_fav_model.dart';
import 'package:elecrama/data/repositories/cache_service.dart';
import 'package:elecrama/data/repositories/network_service.dart';

class FavoriteService {
  final Dio _dio = DioClient.dio;

  Future<List<VisitorFavoriteModel>> getVisitorFavoriteList({
    required int visitorId,
  }) async {
    final cache = CacheService();

    try {
      final isOnline = await NetworkService.isConnected();

      // OFFLINE
      if (!isOnline) {
        final cachedData = cache.get('visitor_favorites');

        if (cachedData != null) {
          return (cachedData as List)
              .map(
                (item) => VisitorFavoriteModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();
        }

        return [];
      }

      // ONLINE
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

      // SAVE RAW RESPONSE
      cache.save('visitor_favorites', decoded);

      return decoded
          .map(
            (item) =>
                VisitorFavoriteModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      // CACHE FALLBACK
      final cachedData = cache.get('visitor_favorites');

      if (cachedData != null) {
        return (cachedData as List)
            .map(
              (item) => VisitorFavoriteModel.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList();
      }

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
    final cache = CacheService();

    try {
      final isOnline = await NetworkService.isConnected();

      if (!isOnline) {
        final cachedData = cache.get('exhibitor_favorites');

        if (cachedData != null) {
          return (cachedData as List)
              .map(
                (item) => ExhibitorFavouriteModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();
        }

        return [];
      }

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

      cache.save('exhibitor_favorites', decoded);

      return decoded
          .map(
            (item) =>
                ExhibitorFavouriteModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      final cachedData = cache.get('exhibitor_favorites');

      if (cachedData != null) {
        return (cachedData as List)
            .map(
              (item) => ExhibitorFavouriteModel.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList();
      }

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
        queryParameters: {
          'ExhibitorId': exhibitorId,
          'ExhibitorUserId': exhibitorUserId,
        },
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
