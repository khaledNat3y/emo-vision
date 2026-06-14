import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;

  RegisterCubit(this._authRepo) : super(const RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    try {
      await _authRepo.signUpWithEmailAndPassword(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(RegisterSuccess(email: email));
    } catch (e) {
      emit(RegisterError(error: e.toString()));
    }
  }
}
