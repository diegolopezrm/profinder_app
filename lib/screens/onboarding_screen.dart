import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:profinder_app/utils/my_colors.dart';

import '../controller/auth_controller.dart';
import '../routes/app_routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final AuthController _authController = Get.find();

  void onOnboardingComplete() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_authController.user!.uid)
        .update({'onboarding': true});

    Get.offNamed(AppRoutes
        .mainScreen); // Navigate to main screen after Onboarding is complete.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        onFinish: () {
          onOnboardingComplete();
        },
        skipFunctionOverride: () {
          onOnboardingComplete();
        },
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Comenzar',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: MyColors.primary
        ),
        skipTextButton: const Text('Saltar'),
        trailing: const Text(''),
        background: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.primary,
                  MyColors.secondary,
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.primary,
                  MyColors.secondary,
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.primary,
                  MyColors.secondary,
                ],
              ),
            ),
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: const <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                    'Welcome to the app. This is a sample onboarding screen.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: const <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                    ' This is a sample onboarding screen.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child:  Column(
              children: const <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                    ' This is a sample onboarding screen.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
