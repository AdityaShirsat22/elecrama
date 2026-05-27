import 'package:elecrama/bindings/home_binding.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/pages/Exhibitor/exhibitorDashboardScreen.dart';
import 'package:elecrama/view/pages/Exhibitor/exhibitorProfileScreen.dart';
import 'package:elecrama/view/pages/Exhibitor/exhibitorSettingScreen.dart';
import 'package:elecrama/view/pages/Exhibitor/exhibitor_details_screen.dart';
import 'package:elecrama/view/pages/Exhibitor/logincodescreen.dart';
import 'package:elecrama/view/pages/Favourite/exhibitorfavscreen.dart';
import 'package:elecrama/view/pages/Favourite/visitorfavscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/b2bbuyerlogin.dart';
import 'package:elecrama/view/pages/LoginScreens/dbsmloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/exhibitorloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/iotloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/multipleloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/rbmsloginscreen.dart';
import 'package:elecrama/view/pages/LoginScreens/visitorloginscreen.dart';
import 'package:elecrama/view/pages/Visitor/visitorDashboardScreen.dart';
import 'package:elecrama/view/pages/Visitor/visitorProfileScreen.dart';
import 'package:elecrama/view/pages/Visitor/visitorSettingScreen.dart';
import 'package:elecrama/view/pages/exhibitorcompanyinfo.dart';
import 'package:elecrama/view/pages/exhibitorlist.dart';
import 'package:elecrama/view/pages/homeScreen.dart';
import 'package:elecrama/view/pages/qrscreen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => Homescreen(),
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
    GetPage(name: AppRoutes.qrscreen, page: () => Qrscreen()),
    GetPage(name: AppRoutes.b2blogin, page: () => B2bbuyerlogin()),
    GetPage(name: AppRoutes.rbsmlogin, page: () => Rbmsloginscreen()),
    GetPage(name: AppRoutes.dbsmlogin, page: () => Dbsmloginscreen()),
    GetPage(name: AppRoutes.iotlogin, page: () => IotLoginScreen()),
    GetPage(name: AppRoutes.visitorHome, page: () => Visitordashboardscreen()),
    GetPage(name: AppRoutes.visitorprofile, page: () => VisitorProfileScreen()),
    GetPage(
      name: AppRoutes.exhibitordetails,
      page: () => ExhibitorDetailsScreen(),
    ),
    GetPage(name: AppRoutes.logincodescreen, page: () => LoginCodeScreen()),
    GetPage(
      name: AppRoutes.exhibitorprofile,
      page: () => Exhibitorprofilescreen(),
    ),
    GetPage(
      name: AppRoutes.exhibitorHome,
      page: () => Exhibitordashboardscreen(),
    ),
    GetPage(
      name: AppRoutes.exhibitorsetting,
      page: () => ExhibitorsettingScreen(),
    ),
    GetPage(name: AppRoutes.visitorsetting, page: () => Visitorsettingscreen()),

    GetPage(name: AppRoutes.exhibitorlist, page: () => ExhibitorList()),
    GetPage(
      name: AppRoutes.exhibitorcompanyinfo,
      page: () => ExhibitorCompanyInfo(),
    ),

    GetPage(name: AppRoutes.visitorfav, page: () => VisitorFavoriteScreen()),
    GetPage(
      name: AppRoutes.exhibitorfav,
      page: () => ExhibitorFavoriteScreen(),
    ),
    GetPage(name: AppRoutes.multiplelogin, page: () => Multipleloginscreen()),
  ];
}
