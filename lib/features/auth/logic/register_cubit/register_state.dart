part of 'register_cubit.dart';

@immutable
sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterSuccess extends RegisterState {
  final String email;
  const RegisterSuccess({required this.email});
}

final class RegisterError extends RegisterState {
  final String error;
  const RegisterError({required this.error});
}