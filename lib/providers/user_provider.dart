import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user.dart';
import 'package:closet_app/services/auth/auth_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fAuth;
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthProvider _authProvider =
      AuthProvider(firebaseAuth: fAuth.FirebaseAuth.instance);

  AppUser? _appUser;

  AppUser? get appUser => _appUser;

  bool get isSignedIn => fAuth.FirebaseAuth.instance.currentUser != null;

  Future<void> signUpWithMailAndPassword({
    required String password,
    required String email,
    String? username,
  }) async {
    fAuth.User? firebaseUser = await _authProvider.signUpWithMailAndPassword(
      password: password,
      email: email,
      username: username,
    );
    if (firebaseUser != null) {
      final QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection(FirestoreConstants.USER_COLLECTION)
          .where(FirestoreConstants.UID, isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isNotEmpty) {
        _appUser =
            AppUser.fromJson(documents.first.data() as Map<String, dynamic>);
        notifyListeners();
      }
    }
  }

  Future<void> signInWithMailAndPassword({
    required String password,
    required String email,
  }) async {
    fAuth.User? firebaseUser = await _authProvider.handleSignIn(
      email,
      password,
    );
    if (firebaseUser != null) {
      final QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection(FirestoreConstants.USER_COLLECTION)
          .where(FirestoreConstants.UID, isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isNotEmpty) {
        _appUser =
            AppUser.fromJson(documents.first.data() as Map<String, dynamic>);
        notifyListeners();
      }
    }
  }

  Future<void> signOut() async {
    await _authProvider.signOut();
    _appUser = null;
    notifyListeners();
  }
}
