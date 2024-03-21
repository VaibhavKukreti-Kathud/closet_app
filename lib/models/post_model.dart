class Post {
  final String postId;
  final String caption;
  final String imageUrl;
  final DateTime postedAt;
  final String postedById;
  final String postedByName;
  final List<dynamic>? likedBy;
  final List<dynamic>? comments;

  Post({
    required this.postId,
    required this.caption,
    required this.imageUrl,
    required this.postedAt,
    required this.postedById,
    required this.postedByName,
    this.likedBy,
    this.comments,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      caption: data['caption'],
      imageUrl: data['imageUrl'],
      postedAt: data['postedAt'],
      postedById: data['postedById'],
      postedByName: data['postedByName'],
      postId: data['postId'],
      likedBy: data['likedBy'],
      comments: data['comments'],
    );
  }
}
