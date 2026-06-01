import 'package:elecrama/data/repositories/auth_service.dart';
import 'package:elecrama/data/repositories/banner_repo.dart';
import 'package:elecrama/data/repositories/hiveservice.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:elecrama/view_model/controller/homecontroller.dart';
import 'package:elecrama/view_model/controller/fav_controller.dart';
import 'package:elecrama/view_model/controller/meetingController.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BannerRepository());
    Get.lazyPut(() => Hiveservice());
    Get.lazyPut(() => AuthService());
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => HomeController(Get.find()));
    Get.put(FavoriteController(), permanent: true);
    Get.put(Meetingcontroller(), permanent: true);
  }
}
