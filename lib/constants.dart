import 'package:flutter/material.dart';

const double kBorderRadius = 20;
const Color kPrimaryColor = Color.fromARGB(255, 255, 255, 255);
const Color kButtonShadowColor = Color.fromARGB(255, 236, 128, 70);
const Color kSecondaryColor = Color(0xFFedbea2);
const Color kDisabledColor = Color(0xffd9c7bd);
const Color kBGFieldColor = Color.fromARGB(255, 239, 247, 255);
const String FUNCTION_SUCCESSFUL = 'Success';

class FirestoreConstants {
  static const USER_COLLECTION = "users";
  static const USERNAME = "username";
  static const PFP_URL = "pfpUrl";
  static const UID = "id";
  static const TIMESTAMP = "timestamp";
  static const EMAIL = "email";
  static const POSTS_COLLECTION = "posts";
  static const LIKES_COLLECTION = "likedBy";
  static const LIKES_COUNT = "likes";
  static const COMMENTS_COLLECTION = "comments";
  static const FAVORITES = "favorites";
}
