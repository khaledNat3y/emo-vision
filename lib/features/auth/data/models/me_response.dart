class MeResponse {
  final String userId;
  final String email;
  final String fullName;
  final String? profilePicture;

  MeResponse({
    required this.userId,
    required this.email,
    required this.fullName,
    this.profilePicture,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      profilePicture: json['profilePicture'],
    );
  }
}