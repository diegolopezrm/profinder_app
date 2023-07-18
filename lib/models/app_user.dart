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
  final String? profilepic;
  final String? role;
  final Map<String, dynamic>? service;
  final String? mainService;

  AppUser(
      {required this.uid,
      this.name,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.birthday,
      this.lastConnection,
      this.interests,
      this.onboarding,
      this.profilepic,
      this.role,
      this.service,
      this.mainService});

  factory AppUser.fromFirebase(User user) {
    return AppUser(
        uid: user.uid,
        name: user.displayName,
        lastName: user.displayName,
        phoneNumber: null,
        address: null,
        birthday: null,
        lastConnection: null,
        interests: null,
        onboarding: false,
        profilepic: null,
        role: null,
        service: null,
        mainService: null);
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
        onboarding: json['onboarding'],
        profilepic: json['profilepic'],
        role: json['role'],
        service: json['service'],
        mainService: json['mainService']);
  }

  factory AppUser.fromSnapshot(
      //map user tomado de firebase a AppUser
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AppUser(
        uid: document.id,
        name: data["name"],
        lastName: data["lastName"],
        phoneNumber: data["phoneNumber"],
        address: data["address"],
        birthday: (data['birthday'] as Timestamp).toDate(),
        lastConnection: (data['lastConnection'] as Timestamp).toDate(),
        interests: List<String>.from(data['interests']),
        profilepic: data['profilepic'],
        role: data['role'],
        service: data['service'],
        mainService: data['mainService']);
  }
}
