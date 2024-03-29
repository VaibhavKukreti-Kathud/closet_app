class AppUser {
  final String uid;
  final pfpUrl;
  final String fullName;
  final String email;
  final String gender;
  final String dob;
  final List<dynamic> exactLocation;
  final String approxLocation;

  const AppUser({
    required this.uid,
    required this.pfpUrl,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.exactLocation,
    required this.approxLocation,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      pfpUrl: json['pfpUrl'],
      fullName: json['fullName'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      exactLocation: json['exactLocation'],
      approxLocation: json['approxLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pfpUrl': pfpUrl,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'dob': dob,
      'exactLocation': exactLocation,
      'approxLocation': approxLocation,
    };
  }
}
