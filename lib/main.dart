import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profinder_app/utils/my_colors.dart';

import 'controller/auth_controller.dart';

import 'firebase_options.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GPS App',
      theme: ThemeData(
        primarySwatch:  MaterialColor(
          MyColors.primary.value,
          const <int, Color>{
            50: MyColors.primary,
            100: MyColors.primary,
            200: MyColors.primary,
            300: MyColors.primary,
            400: MyColors.primary,
            500: MyColors.primary,
            600: MyColors.primary,
            700: MyColors.primary,
            800: MyColors.primary,
            900: MyColors.primary,
          },
        ),
      ),
      initialRoute: authController.user != null
          ? AppRoutes.mainScreen
          : AppRoutes.authLogin,
      routes: AppRoutes.routes,
    );
  }
}
