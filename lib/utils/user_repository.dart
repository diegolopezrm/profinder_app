import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profinder_app/models/app_user.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  Future<AppUser> getUserDetails(String uid) async {
    final snapshot = await
    FirebaseFirestore.instance
    .collection('users').doc(uid).get();
    return AppUser.fromJson(snapshot.data()!);
  }
}