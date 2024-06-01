import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String recieverId;
  String photoUrl;
  String messageText;
  String messageId;
  Timestamp timestamp;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.photoUrl,
    required this.messageText,
    required this.messageId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'photoUrl': photoUrl,
      'messageText': messageText,
      'messageId': messageId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      photoUrl: map['photoUrl'],
      messageText: map['messageText'],
      messageId: map['messageId'],
      timestamp: map['timestamp'],
    );
  }
}
