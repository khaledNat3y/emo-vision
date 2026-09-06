class RegisterRequestBody {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  RegisterRequestBody({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) => RegisterRequestBody(
    email: json['email'],
    password: json['password'],
    firstName: json['firstName'],
    lastName: json['lastName'],
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
  };
}