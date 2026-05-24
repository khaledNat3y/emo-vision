import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SupabaseAuthService _authService;

  RegisterCubit(this._authService) : super(const RegisterInitial());

  Future<void> register({required String email, required String password}) async {
    emit(const RegisterLoading());
    try {
      await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess(email: email));
    } catch (e) {
      emit(RegisterError(error: e.toString()));
    }
  }
}