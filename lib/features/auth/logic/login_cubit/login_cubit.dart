import 'package:facial_emotional_detection_graduation_project/core/networking/api_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/logger.dart';
import '../../data/models/login_request_body.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(LoginInitial());
  
  Future<void>login({required LoginRequestBody body}) async {
    emit(LoginLoading());
    final result = await authRepo.login(body: body);
    result.when(onSuccess: (data) async{
      Logger.info(data.toString());
      emit(LoginSuccess());
    }, onError: (error) {
      Logger.error(error.toString());
      emit(LoginError(error: error));
    });
  }
}
