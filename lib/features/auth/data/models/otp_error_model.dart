// To parse this JSON data, do
//
//     final otpErrorModel = otpErrorModelFromJson(jsonString);

import 'dart:convert';

OtpErrorModel otpErrorModelFromJson(String str) =>
    OtpErrorModel.fromJson(json.decode(str));

String otpErrorModelToJson(OtpErrorModel data) => json.encode(data.toJson());

class OtpErrorModel {
  int statusCode;
  String message;
  Errors errors;

  OtpErrorModel({
    required this.statusCode,
    required this.message,
    required this.errors,
  });

  factory OtpErrorModel.fromJson(Map<String, dynamic> json) => OtpErrorModel(
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
  List<String> otp;

  Errors({required this.otp});

  factory Errors.fromJson(Map<String, dynamic> json) {
    final data = json["otp"];

    if (data is List) {
      return Errors(otp: data.map((e) => e.toString()).toList());
    } else if (data is String) {
      return Errors(otp: [data]);
    } else {
      return Errors(otp: ["Invalid OTP"]);
    }
  }

  Map<String, dynamic> toJson() => {"otp": otp};
}

