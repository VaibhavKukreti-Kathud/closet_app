import 'dart:developer';

import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:closet_app/services/auth/auth_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fAuth;
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AppUser? _appUser;

  AppUser? get appUser => _appUser;

  bool get isSignedIn => fAuth.FirebaseAuth.instance.currentUser != null;

  Future<void> fetchUser() async {
    if (isSignedIn) {
      final fAuth.User? firebaseUser = fAuth.FirebaseAuth.instance.currentUser;
      final DocumentSnapshot userDoc = await _firestore
          .collection(FirestoreConstants.USER_COLLECTION)
          .doc(firebaseUser!.uid)
          .get();
      _appUser = AppUser.fromJson(userDoc.data() as Map<String, dynamic>);
      notifyListeners();
    }
  }

  Future<AppUser> fetchUserById(String id) async {
    final DocumentSnapshot userDoc = await _firestore
        .collection(FirestoreConstants.USER_COLLECTION)
        .doc(id)
        .get();
    return AppUser.fromJson(userDoc.data() as Map<String, dynamic>? ?? {});
  }
}
