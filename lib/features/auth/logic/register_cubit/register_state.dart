abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final String email;
  const RegisterSuccess({required this.email});
}

class RegisterError extends RegisterState {
  final String error;
  const RegisterError({required this.error});
}