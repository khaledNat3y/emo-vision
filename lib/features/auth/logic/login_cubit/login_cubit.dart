import 'package:facial_emotional_detection_graduation_project/core/networking/api_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_response.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/logger.dart';
import '../../data/models/login_request_body.dart';
import '../../data/models/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(LoginInitial());
  
  Future<void>login({required LoginRequestBody body}) async {
    emit(LoginLoading());
    final result = await authRepo.login(body: body);
    result.when(onSuccess: (data) async{
      Logger.info(data.toString());
      emit(LoginSuccess(loginResponse: data));
    }, onError: (error) {
      Logger.error(error.toString());
      emit(LoginError(error: error));
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    emit(LoginWithGoogleLoading());
    try {
      final result = await authRepo.signInWithGoogle();
      final email = result.additionalUserInfo?.profile?['email'] as String?;
      final userName = result.user?.displayName ?? result.additionalUserInfo?.profile?['name'] as String? ?? 'Google User';
      final photoUrl = result.user?.photoURL ?? result.additionalUserInfo?.profile?['picture'] as String?;
      Logger.info('Email: $email, Name: $userName, Photo URL: $photoUrl');
      emit(LoginWithGoogleSuccess(email: email, userName: userName, photoUrl: photoUrl));
      return result;
    } catch (e) {
      emit(LoginError(error: ApiErrorModel(
          message: "Google sign-in cancelled",
          statusCode: null,
          errors: [e.toString()],
      )));
      return null;
    }
  }
}
