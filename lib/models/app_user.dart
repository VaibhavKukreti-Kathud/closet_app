class AppUser {
  final String fullName;
  final String email;
  final String gender;
  final String dob;
  final List<dynamic> exactLocation;
  final String approxLocation;

  const AppUser({
    required this.fullName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.exactLocation,
    required this.approxLocation,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      fullName: json['fullName'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      exactLocation: json['exactLocation'],
      approxLocation: json['approxLocation'],
    );
  }
}
