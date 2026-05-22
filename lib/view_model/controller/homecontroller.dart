import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:elecrama/Api/auth_token.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/bannermodel.dart';
import 'package:elecrama/data/repositories/banner_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final BannerRepository repository;

  HomeController(this.repository);

  var isLoading = true.obs;
  var bannerList = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void fetchBanners() async {
    try {
      isLoading(true);
      final data = await repository.getBanners();
      bannerList.assignAll(data);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<Uint8List> getImage(String url) async {
    final response = await DioClient.dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {"Authorization": "Bearer ${AuthToken.token}"},
      ),
    );
    return Uint8List.fromList(response.data);
  }
}
