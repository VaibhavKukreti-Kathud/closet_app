class AppUser {
  final String id;
  final String? pfpUrl;
  final String fullName;
  final String email;
  final String? gender;
  final String? dob;
  final List<dynamic>? exactLocation;
  final String? approxLocation;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  final List<dynamic>? posts;
  final List<dynamic>? savedPosts;
  final List<dynamic>? likedPosts;

  const AppUser({
    required this.id,
    required this.pfpUrl,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.exactLocation,
    required this.approxLocation,
    required this.followers,
    required this.following,
    required this.posts,
    required this.savedPosts,
    required this.likedPosts,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      pfpUrl: json['pfpUrl'],
      fullName: json['fullName'] ?? 'User',
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      exactLocation: json['exactLocation'],
      approxLocation: json['approxLocation'],
      followers: json['followers'] ?? [],
      following: json['following'] ?? [],
      posts: json['posts'] ?? [],
      savedPosts: json['savedPosts'] ?? [],
      likedPosts: json['likedPosts'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pfpUrl': pfpUrl,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'dob': dob,
      'exactLocation': exactLocation,
      'approxLocation': approxLocation,
      'followers': followers,
      'following': following,
      'posts': posts,
      'savedPosts': savedPosts,
      'likedPosts': likedPosts,
    };
  }
}
