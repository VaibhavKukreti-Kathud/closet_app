import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  final FirebaseAuth firebaseAuth;

  AuthProvider({
    required this.firebaseAuth,
  });

  bool isLoggedIn() {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return isLoggedIn;
  }

  Future signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User?> signUpWithMailAndPassword(
      {required String password,
      required String email,
      String? username,
      String? pfpUrl}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        await firebaseFirestore
            .collection(FirestoreConstants.USER_COLLECTION)
            .doc(firebaseUser.uid)
            .set({
          FirestoreConstants.USERNAME: username ?? email.split('@')[0],
          FirestoreConstants.PFP_URL: pfpUrl,
          FirestoreConstants.UID: firebaseUser.uid,
          FirestoreConstants.EMAIL: email,
        });
      }
      return firebaseUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> handleSignIn(String email, String password) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    return firebaseUser;
  }

  Future<String> sendPasswordResetLinkMail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return FUNCTION_SUCCESSFUL;
    } catch (e) {
      return e.toString();
    }
  }
}
