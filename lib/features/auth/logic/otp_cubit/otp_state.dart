part of 'otp_cubit.dart';

@immutable
sealed class OtpState {
  const OtpState();
}

final class OtpInitial extends OtpState {
  const OtpInitial();
}

final class OtpLoading extends OtpState {
  const OtpLoading();
}

final class OtpSuccess extends OtpState {
  const OtpSuccess();
}

final class OtpError extends OtpState {
  final String error;
  const OtpError({required this.error});
}