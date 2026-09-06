import 'package:json_annotation/json_annotation.dart';
part 'resend_otp_request_body.g.dart';

@JsonSerializable()
class ResendOtpRequestBody {
  final String email;

  ResendOtpRequestBody({required this.email});

  factory ResendOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpRequestBodyToJson(this);
}
