class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String provider;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
    required this.provider,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'] ?? '',
      provider: map['provider'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoURL': photoURL,
      'provider': provider,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
