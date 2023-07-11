// app_routes.dart
import 'package:flutter/material.dart';

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

  static final Map<String, WidgetBuilder> routes = {
    authLogin: (BuildContext context) => const LoginScreen(),
    mainScreen: (BuildContext context) => const MainScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    onboarding: (BuildContext context) => const OnBoardingScreen()
  };
}
