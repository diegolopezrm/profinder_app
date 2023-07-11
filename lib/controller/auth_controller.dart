import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/app_user.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _user = Rx<AppUser?>(null);
  AppUser? get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges().map((User? firebaseUser) =>
        firebaseUser != null ? AppUser.fromFirebase(firebaseUser) : null));
    super.onInit();
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      if (user != null) {
        final usersRef = FirebaseFirestore.instance.collection('users');
        final userDoc = await usersRef.doc(user.uid).get();

        if (userDoc.exists) {
          _user.value = AppUser.fromJson(userDoc.data()!);
          Get.offAllNamed(AppRoutes.mainScreen);
        } else {
          Get.offAllNamed(AppRoutes.register);
        }
      }
      return user != null ? AppUser.fromFirebase(user) : null;
    } catch (e) {
      // Handle the error here
      // For example, show a dialog with the error message
      log('Failed to sign in with Google');
      Get.snackbar(
        'Error',
        'Failed to sign in with Google: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }


  void signOut() {
    _auth.signOut().then((value) => Get.offAllNamed(AppRoutes.authLogin));
  }
}
