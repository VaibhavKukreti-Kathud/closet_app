import 'package:closet_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  Future getFavorites() async {
    String userId = _auth.currentUser!.uid;
    // Get favorites from the database
    final Stream<DocumentSnapshot<Map<String, dynamic>>> userDoc =
        await _firestore
            .collection(FirestoreConstants.USER_COLLECTION)
            .doc(userId)
            .snapshots();

    userDoc.listen((event) {
      _favorites = (event.data()![FirestoreConstants.FAVORITES]).map((element) {
        return element.toString();
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addFavorite(String postId) async {
    String userId = _auth.currentUser!.uid;
    // Add the favorite to the user's favorites list
    await _firestore
        .collection(FirestoreConstants.USER_COLLECTION)
        .doc(userId)
        .update({
      FirestoreConstants.FAVORITES: FieldValue.arrayUnion([postId])
    });

    _favorites.add(postId);

    notifyListeners();
  }

  Future<void> removeFavorite(String postId) async {
    String userId = _auth.currentUser!.uid;
    // Remove the favorite from the user's favorites list
    await _firestore
        .collection(FirestoreConstants.USER_COLLECTION)
        .doc(userId)
        .update({
      FirestoreConstants.FAVORITES: FieldValue.arrayRemove([postId])
    });

    _favorites.remove(postId);

    notifyListeners();
  }

  bool isFavorite(String postId) {
    return _favorites.contains(postId);
  }
}
