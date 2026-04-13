import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/verify_email_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo _authRepo;

  OtpCubit(this._authRepo) : super(OtpInitial());

  Future<void> verifyOTP({
    required String email,
    required String otp,
  }) async {
    emit(OtpLoading());

    final result = await _authRepo.verifyEmail(
      VerifyEmailRequestBody(email: email, otp: otp),
    );

    result.fold(
          (errorMessage) => emit(OtpError(error: errorMessage)),
          (_) => emit(const OtpSuccess()),
    );
  }
}