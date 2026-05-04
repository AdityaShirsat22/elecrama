import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/auth_token.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/bannermodel.dart';

class BannerRepository {
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await DioClient.dio.get(
        ApiConstants.bannerurl,
        options: Options(
          headers: {'Authorization': 'Bearer ${AuthToken.token}'},
        ),
      );

      List data = response.data;

      return data.map((e) => BannerModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error fetching banners: $e');
    }
  }
}
