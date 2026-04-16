part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  ForgotPasswordError(this.message);
}

final class ResetPasswordLoading extends ForgotPasswordState {}

final class ResetPasswordSuccess extends ForgotPasswordState {
  final String message;

  ResetPasswordSuccess(this.message);
}

final class ResetPasswordError extends ForgotPasswordState {
  final String message;

  ResetPasswordError(this.message);
}
