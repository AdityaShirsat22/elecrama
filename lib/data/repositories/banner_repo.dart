import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/auth_token.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/bannermodel.dart';
import 'package:elecrama/data/repositories/cache_service.dart';
import 'package:elecrama/data/repositories/network_service.dart';

class BannerRepository {
  final CacheService _cacheService = CacheService();

  Future<List<BannerModel>> getBanners() async {
    try {
      final isOnline = await NetworkService.isConnected();

      // ONLINE MODE
      if (isOnline) {
        final response = await DioClient.dio.get(
          ApiConstants.bannerurl,
          options: Options(
            headers: {'Authorization': 'Bearer ${AuthToken.token}'},
          ),
        );

        List data = response.data;

        // Save response to cache
        _cacheService.save('banners', response.data);

        return data.map((e) => BannerModel.fromJson(e)).toList();
      }

      // OFFLINE MODE
      final cachedData = _cacheService.get('banners');

      if (cachedData != null) {
        return (cachedData as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
      }

      return [];
    } catch (e) {
      // If API fails, try cache

      final cachedData = _cacheService.get('banners');

      if (cachedData != null) {
        return (cachedData as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
      }

      throw Exception('Error fetching banners: $e');
    }
  }
}
