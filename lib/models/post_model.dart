import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String? caption;
  final String imageUrl;
  final Timestamp postedAt;
  final String postedById;
  final String postedByName;
  final String? category;
  final String profilePfp;
  final String? color;
  final String? size;
  final int? sizeNumber;
  final List<dynamic>? likedBy;
  final List<dynamic>? comments;

  Post({
    required this.postId,
    required this.caption,
    required this.imageUrl,
    required this.postedAt,
    required this.postedById,
    required this.postedByName,
    required this.category,
    required this.profilePfp,
    this.color,
    this.size,
    this.sizeNumber,
    this.likedBy,
    this.comments,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      postId: data['postId'],
      caption: data['caption'] ?? '',
      imageUrl: data['imageUrl'],
      postedAt: data['postedAt'],
      postedById: data['postedById'],
      postedByName: data['postedByName'],
      profilePfp: data['profilePfp'],
      color: data['color'] ?? '',
      sizeNumber: data['sizeNumber'] ?? 0,
      size: data['size'] ?? '',
      likedBy: data['likedBy'] ?? [],
      comments: data['comments'] ?? [],
      category: data['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'caption': caption,
      'imageUrl': imageUrl,
      'postedAt': postedAt,
      'postedById': postedById,
      'sizeNumber': sizeNumber,
      'color': color,
      'size': size,
      'postedByName': postedByName,
      'profilePfp': profilePfp,
      'likedBy': likedBy,
      'comments': comments,
      'category': category,
    };
  }
}
