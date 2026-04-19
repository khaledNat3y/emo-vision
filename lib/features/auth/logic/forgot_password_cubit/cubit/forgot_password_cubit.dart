import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/resend_otp_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/reset_password_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo _authRepo;

  Timer? _resendTimer;
  int remainingSeconds = 0;

  bool get isTimerActive => remainingSeconds > 0;

  String get timerText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  ForgotPasswordCubit(this._authRepo) : super(ForgotPasswordInitial());

  void startResendTimer() {
    _resendTimer?.cancel();
    remainingSeconds = 600;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        timer.cancel();
        emit(ResendOtpTimerFinished());
      } else {
        emit(ResendOtpTimerTick(remainingSeconds));
      }
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }

  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final result = await _authRepo.forgotPassword(email);
      Logger.debug("result: $result");
      emit(ForgotPasswordSuccess(result));
    } catch (e) {
      Logger.debug(e.toString());
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> resetPassword(ResetPasswordRequestBody body) async {
    emit(ResetPasswordLoading());
    try {
      final result = await _authRepo.resetPassword(body: body);
      Logger.debug("result: $result");
      emit(ResetPasswordSuccess(result));
    } catch (e) {
      Logger.debug(e.toString());
      emit(ResetPasswordError(e.toString()));
    }
  }

  Future<void> resendOtp(ResendOtpRequestBody body) async {
    emit(ResendOtpLoading());
    try {
      final result = await _authRepo.resendOtp(body: body);
      Logger.debug("result: $result");
      emit(ResendOtpSuccess(result));
    } catch (e) {
      Logger.debug(e.toString());
      emit(ResendOtpError(e.toString()));
    }
  }
}
