import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo _authRepo;

  ForgotPasswordCubit(this._authRepo) : super(const ForgotPasswordInitial());

  Future<void> forgotPassword(String email) async {
    emit(const ForgotPasswordLoading());
    try {
      await _authRepo.resetPasswordForEmail(email);
      emit(const ForgotPasswordSuccess('Password reset email sent'));
    } catch (e) {
      Logger.error(e.toString());
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
