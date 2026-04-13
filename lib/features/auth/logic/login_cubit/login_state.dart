abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginWithGoogleLoading extends LoginState {
  const LoginWithGoogleLoading();
}

class LoginSuccess extends LoginState {
  final String email;
  final String userName;

  const LoginSuccess({required this.email, required this.userName});
}

class LoginWithGoogleSuccess extends LoginState {
  final String email;
  final String userName;
  final String photoUrl;

  const LoginWithGoogleSuccess({
    required this.email,
    required this.userName,
    required this.photoUrl,
  });
}

class LoginError extends LoginState {
  final String error;

  const LoginError({required this.error});
}