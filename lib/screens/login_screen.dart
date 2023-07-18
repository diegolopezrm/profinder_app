import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:metaballs/metaballs.dart';
import 'package:profinder_app/utils/my_colors.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Metaballs(
        effect: MetaballsEffect.follow(
          growthFactor: 1,
          smoothing: 1,
          radius: 0.5,
        ),
        gradient: const LinearGradient(colors: [
          MyColors.primary,
          MyColors.secondary,
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        metaballs: 40,
        animationDuration: const Duration(milliseconds: 200),
        speedMultiplier: 1,
        bounceStiffness: 3,
        minBallRadius: 15,
        maxBallRadius: 40,
        glowRadius: 0,
        glowIntensity: 0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Image
              const SizedBox(
                //logo app placeholder
                width: 300,
                height: 300,
                //logo app image png asset

                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 20),
              // Game's Slogan or Tagline
              const SizedBox(
                width: 300,
                child: Text(
                  'Find the best professionals in your area',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                  //salto de linea
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 200),
              // Sign in with Google Button
              Column(
                children: [
                  //text helper for google button
                  const Text(
                    'Sign in options',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      _authController.signInWithGoogle().then((value) {
                        setState(() {});
                        Get.snackbar(
                          'Bienvenido',
                          'Has iniciado sesión correctamente',
                          backgroundColor: MyColors.secondary,
                          colorText: MyColors.primary,
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
