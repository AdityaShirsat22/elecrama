import 'package:elecrama/model/bannermodel.dart';

List<BannerModel> banners = [];

Future<void> loadBanners() async {
  banners = await repository.getBanners();
  notifyListeners();
}