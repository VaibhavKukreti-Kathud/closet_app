import 'package:closet_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFunctions {
  Stream<List<Message>> fetchChatMessages(String cId, String cwId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(cId)
        .collection('messages')
        .doc(cwId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList());
  }
}
