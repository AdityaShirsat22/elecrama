import 'package:elecrama/bindings/home_binding.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/pages/LoginScreens/b2bbuyerlogin.dart';
import 'package:elecrama/view/pages/LoginScreens/dbsmloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/exhibitorloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/iotloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/rbmsloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/visitorloginscreen.dart';
import 'package:elecrama/view/pages/Visitor/visitorDashboardScreen.dart';
import 'package:elecrama/view/pages/Visitor/visitorProfileScreen.dart';
import 'package:elecrama/view/pages/homeScreen.dart';
import 'package:elecrama/view/pages/qrscreen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const Homescreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.exhibitorlogin,
      page: () => const Exhibitorloginscreen(),
    ),
    GetPage(
      name: AppRoutes.visitorlogin,
      page: () => const Visitorloginscreen(),
    ),
    GetPage(name: AppRoutes.qrscreen, page: () => const Qrscreen()),
    GetPage(name: AppRoutes.b2blogin, page: () => const B2bbuyerlogin()),
    GetPage(name: AppRoutes.rbsmlogin, page: () => const Rbmsloginscreen()),
    GetPage(name: AppRoutes.dbsmlogin, page: () => const Dbsmloginscreen()),
    GetPage(name: AppRoutes.iotlogin, page: () => const IotLoginScreen()),
    GetPage(
      name: AppRoutes.visitorHome,
      page: () => Visitordashboardscreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.visitorProfile,
      page: () => VisitorProfileScreen(),
      binding: HomeBinding(),
    ),
  ];
}
