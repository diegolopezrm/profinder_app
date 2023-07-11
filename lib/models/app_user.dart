// app_user.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String? name;
  final String? lastName;
  final String? phoneNumber;
  final String? address;
  final DateTime? birthday;
  final DateTime? lastConnection;
  final List<String>? interests;
  final bool? onboarding;

  AppUser({
    required this.uid,
    this.name,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.lastConnection,
    this.interests,
    this.onboarding
  });

  factory AppUser.fromFirebase(User user) {
    return AppUser(
      uid: user.uid,
      name: user.displayName,
      lastName: user.displayName,
      phoneNumber: '',
      address: '',
      birthday: null,
      lastConnection: null,
      interests: [],
      onboarding: false
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: FirebaseAuth.instance.currentUser!.uid,
      name: json['name'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      birthday: (json['birthday'] as Timestamp).toDate(),
      lastConnection: (json['lastConnection'] as Timestamp).toDate(),
      interests: List<String>.from(json['interests']),
      onboarding: json['onboarding']
    );
  }
}
