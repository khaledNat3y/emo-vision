class VerifyEmailRequestBody {
  final String email;
  final String otp;

  VerifyEmailRequestBody({
    required this.email,
    required this.otp,
  });

  factory VerifyEmailRequestBody.fromJson(Map<String, dynamic> json) {
    return VerifyEmailRequestBody(
      email: json['email'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
};

}