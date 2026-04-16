import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/reset_password_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/http.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo _authRepo;
  ForgotPasswordCubit(this._authRepo) : super(ForgotPasswordInitial());

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
}
