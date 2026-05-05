import 'package:elecrama/bindings/home_binding.dart';
import 'package:elecrama/routes/app_pages.dart';
import 'package:elecrama/routes/app_routes.dart';
import 'package:elecrama/view/pages/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homescreen(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
    );
  }
}
