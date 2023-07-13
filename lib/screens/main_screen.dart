import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profinder_app/screens/category/category_home_screen.dart';
import 'package:profinder_app/utils/my_colors.dart';
import 'package:profinder_app/widgets/upload_data.dart';

import '../controller/auth_controller.dart';
import '../routes/app_routes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthController _authController = Get.find();
  int _page = 0;
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
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Widget> _buildScreens() {
    return [
      const CategoryHomeScreen(),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
      const MyWidget()
    ];
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
          child: _buildScreens()[_page],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: MyColors.secondary,
            items: const <Widget>[
              Icon(Icons.home, size: 30, color: MyColors.primary),
              Icon(Icons.search, size: 30, color: MyColors.primary),
              Icon(Icons.book, size: 30, color: MyColors.primary),
              Icon(Icons.people, size: 30, color: MyColors.primary),
              Icon(Icons.emoji_events, size: 30, color: MyColors.primary),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          ),
        ),
      ]),
    );
  }
}
