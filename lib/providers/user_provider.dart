import 'package:closet_app/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool get isSignedIn => firebaseAuth.currentUser != null;

  User? get user => firebaseAuth.currentUser;
  AppUser? currentAppUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> signInMail(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> signUpMail(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> updateAppUser(AppUser appUser) async {
    notifyListeners();
  }

  Future<AppUser?> getCurrentAppUser() async {
    final user = firebaseAuth.currentUser;
    final userData = await users.doc(user!.uid).get();
    currentAppUser = userData.data() == null
        ? null
        : AppUser.fromJson(userData.data() as Map<String, dynamic>);
    notifyListeners();
    return currentAppUser;
  }

  Future<AppUser> fetchAppUserFromUserId(String userId) async {
    final userData = await users.doc(userId).get();
    return AppUser.fromJson(userData.data() as Map<String, dynamic>);
  }
}
