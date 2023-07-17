// app_routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profinder_app/widgets/upload_data.dart';

import '../models/category.dart';
import '../screens/category/category_home_screen.dart';
import '../screens/category/category_selection_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/register_screen.dart';


class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String mainScreen = '/main';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String categoryHome = '/category-home';
  static const String uploadData = '/upload-data';
  static const String categorySelection = '/category-selection';

  static final Map<String, WidgetBuilder> routes = {
    authLogin: (BuildContext context) => const LoginScreen(),
    mainScreen: (BuildContext context) => const MainScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    onboarding: (BuildContext context) => const OnBoardingScreen(),
    categoryHome: (BuildContext context) => const CategoryHomeScreen(),
    uploadData: (BuildContext context) => const MyWidget(),
    categorySelection: (BuildContext context) {
        var category = Get.arguments as Category;
        return CategorySelectionScreen(category: category);
    },
  };
}
