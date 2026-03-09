part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginWithGoogleLoading extends LoginState {}

class LoginWithGoogleSuccess extends LoginState {
  final String? email;
  final String? userName;
  final String? photoUrl;
  
  LoginWithGoogleSuccess({this.email, this.userName, this.photoUrl});
}

class LoginSuccess extends LoginState {
  final LoginResponse? loginResponse;
  final String? email;
  LoginSuccess({this.loginResponse, this.email});
}

class LoginError extends LoginState {
  final ApiErrorModel error;

  LoginError({required this.error});
}