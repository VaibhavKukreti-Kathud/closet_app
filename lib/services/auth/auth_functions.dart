import 'package:closet_app/constants.dart';
import 'package:closet_app/models/app_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFunctions {
  final FirebaseAuth firebaseAuth;
  final SharedPreferences prefs;

  AuthFunctions({
    required this.firebaseAuth,
    required this.prefs,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.UID);
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (isLoggedIn &&
        prefs.getString(FirestoreConstants.UID)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> signUpWithMailAndPassword(
      {required String password,
      required String email,
      String? username,
      String? photoUrl}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      handleSignIn(email, password, username, photoUrl);
      return FUNCTION_SUCCESSFUL;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> handleSignIn(
      String email, String password, String? username, String? pfpUrl) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.USER_COLLECTION)
          .where(FirestoreConstants.UID, isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        // Writing data to server because here is a new user
        firebaseFirestore
            .collection(FirestoreConstants.USER_COLLECTION)
            .doc(firebaseUser.uid)
            .set({
          FirestoreConstants.USERNAME:
              username ?? firebaseUser.email!.split('@')[0],
          FirestoreConstants.PFP_URL: pfpUrl,
          FirestoreConstants.UID: firebaseUser.uid,
          FirestoreConstants.EMAIL: firebaseUser.email,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        });

        // Write data to local storage
        User? currentUser = firebaseUser;
        await prefs.setString(FirestoreConstants.UID, currentUser.uid);
        await prefs.setString(
            FirestoreConstants.USERNAME, currentUser.displayName ?? "");
        await prefs.setString(
            FirestoreConstants.PFP_URL, currentUser.photoURL ?? "");
      } else {
        // Already sign up, just get data from firestore
        DocumentSnapshot documentSnapshot = documents[0];
        AppUser userChat =
            AppUser.fromJson(documentSnapshot as Map<String, dynamic>);
        // Write data to local
        await prefs.setString(FirestoreConstants.UID, userChat.uid);
        await prefs.setString(
            FirestoreConstants.USERNAME, userChat.fullName.split(' ').first);
        await prefs.setString(FirestoreConstants.PFP_URL, userChat.pfpUrl);
      }
      return FUNCTION_SUCCESSFUL;
    } else {
      return 'Something went wrong.';
    }
  }

  Future<String> signInPhoneWithOTP(String phone, String otp) async {
    try {
      await firebaseAuth.signInWithPhoneNumber(phone).then((value) {
        print(value);
      });
      return FUNCTION_SUCCESSFUL;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> sendPasswordResetLinkMail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return FUNCTION_SUCCESSFUL;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      await prefs.clear();
      return FUNCTION_SUCCESSFUL;
    } catch (e) {
      return e.toString();
    }
  }
}
