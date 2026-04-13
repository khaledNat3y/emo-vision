import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/register_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';

import '../../data/models/register_response.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;

  RegisterCubit(this._authRepo) : super(RegisterInitial());

  Future<void> register({required RegisterRequestBody body}) async {
    emit(RegisterLoading());

    final result = await _authRepo.register(body);

    result.fold(
          (errorMessage) => emit(RegisterError(error: errorMessage)),
          (_) => emit(RegisterSuccess(email: body.email)),
    );
  }
}