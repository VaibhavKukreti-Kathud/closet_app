import 'package:closet_app/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalFeedService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getFeed() async {
    List<String> feed = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .get();
    snapshot.docs.forEach((element) {
      feed.add(element.id);
    });
    return feed;
  }
}
