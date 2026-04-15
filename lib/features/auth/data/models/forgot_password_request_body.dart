import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_body.g.dart';

@JsonSerializable()
class ForgotPasswordRequestBody {
  final String email;

  ForgotPasswordRequestBody({required this.email});

  factory ForgotPasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestBodyToJson(this);
}
