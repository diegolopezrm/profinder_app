import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profinder_app/controller/tab_controller.dart';
import 'package:profinder_app/models/app_user.dart';
import 'package:profinder_app/screens/category/category_home_screen.dart';
import 'package:profinder_app/screens/profile_prestador/profile_prestador_config_screen.dart';
import 'package:profinder_app/utils/my_colors.dart';
import 'package:profinder_app/widgets/coming_soon_widgtet.dart';
import 'package:profinder_app/widgets/upload_data.dart';

import '../controller/auth_controller.dart';
import '../routes/app_routes.dart';

import '../widgets/settings_screen.dart';
import '../widgets/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthController _authController = Get.find();
  final TabControllerApp _tabController = Get.find();

  Map<String, dynamic>? data;
  bool _isLoading = true;
  int? soundId;

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  Future<void> fetchData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_authController.user!.uid)
        .get();

    data = doc.data() as Map<String, dynamic>?;

    if (data == null ||
        data!['name'] == null ||
        data!['lastName'] == null ||
        data!['phoneNumber'] == null ||
        data!['address'] == null ||
        data!['birthday'] == null) {
      // If the document does not exist or if any of the required fields are null, redirect to the registration page.
      log('The document does not exist or one of the required fields is null.');
      Future.delayed(Duration.zero, () {
        Get.offNamed(AppRoutes.register);
      });
    } else if (data!['onboarding'] == null || !data!['onboarding']) {
      // If 'onboarding' field is null or false, navigate to Onboarding screen.
      Future.delayed(Duration.zero, () {
        Get.offNamed(AppRoutes
            .onboarding); // Replace 'AppRoutes.onboarding' with your Onboarding screen route.
      });

      final AppUser user = AppUser(
        uid: _authController.user!.uid,
        name: data!['name'],
        lastName: data!['lastName'],
        phoneNumber: data!['phoneNumber'],
        address: data!['address'],
        birthday: data!['birthday'],
        role: data!['role'],
        onboarding: data!['onboarding'],
        mainService: data!['mainService'],
        service: data!['service'],
        profilepic: data!['profilepic'],
      );

      setState(() {
        _authController.updateLocalUser(user);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Widget> _buildScreensCliente() {
    return [
      const CategoryHomeScreen(),
      const ComingSoonScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];
  }

  List<Widget> _buildScreensPrestador() {
    return [
      const CategoryHomeScreen(),
      const ComingSoonScreen(),
      const ComingSoonScreen(),
      const ProfilePrestadorConfigScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];
  }

  List<Widget> _buildScreens() {
    if (data!['role'] == 'prestador') {
      return _buildScreensPrestador();
    } else {
      return _buildScreensCliente();
    }
  }

  List<Widget> _buildIconsCliente() {
    return [
      const Icon(Icons.home, size: 30, color: MyColors.primary),
      const Icon(Icons.history, size: 30, color: MyColors.primary),
      const Icon(Icons.person, size: 30, color: MyColors.primary),
      const Icon(Icons.settings, size: 30, color: MyColors.primary),
    ];
  }

  List<Widget> _buildIconsPrestador() {
    return [
      const Icon(Icons.home, size: 30, color: MyColors.primary),
      const Icon(Icons.history, size: 30, color: MyColors.primary),
      const Icon(Icons.work, size: 30, color: MyColors.primary),
      const Icon(Icons.build, size: 30, color: MyColors.primary),
      const Icon(Icons.person, size: 30, color: MyColors.primary),
      const Icon(Icons.settings, size: 30, color: MyColors.primary),
    ];
  }

  List<Widget> _buildIcons() {
    if (data!['role'] == 'prestador') {
      return _buildIconsPrestador();
    } else {
      return _buildIconsCliente();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Stack(children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildScreens()[_tabController.page],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: MyColors.secondary,
            items: _buildIcons(),
            onTap: (index) {
              setState(() {
                _tabController.setPage(index);
              });
            },
          ),
        ),
      ]),
    );
  }
}
