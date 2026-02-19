part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponse data;

  RegisterSuccess(this.data);

}

final class RegisterError extends RegisterState {
  final ApiErrorModel error;

  RegisterError({required this.error});


}
