import 'package:elecrama/data/repositories/banner_repo.dart';
import 'package:elecrama/view_model/controller/homecontroller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BannerRepository());
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
