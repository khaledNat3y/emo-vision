// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  int statusCode;
  String message;
  Errors errors;

  ErrorModel({
    required this.statusCode,
    required this.message,
    required this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    statusCode: json["statusCode"],
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  List<String> email;
  List<String> password;

  Errors({
    required this.email,
    required this.password,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: List<String>.from(json["email"].map((x) => x)),
    password: List<String>.from(json["password"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),
    "password": List<dynamic>.from(password.map((x) => x)),
  };
}
