// lib/features/auth/logic/update_password_cubit/update_password_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_state.dart';
part 'update_password_cubit.freezed.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final SupabaseAuthService _authService;

  UpdatePasswordCubit(this._authService)
    : super(const UpdatePasswordState.initial());

  Future<void> updatePassword(String newPassword) async {
    emit(const UpdatePasswordState.loading());
    try {
      await _authService.updatePassword(newPassword);
      emit(const UpdatePasswordState.success());
    } catch (e) {
      emit(UpdatePasswordState.error(e.toString()));
    }
  }
}
