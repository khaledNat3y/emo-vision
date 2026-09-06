import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo _authRepo;

  LogoutCubit(this._authRepo) : super(const LogoutInitial());

  Future<void> logout() async {
    emit(const LogoutLoading());

    try {
      final isGoogle =
      await SharedPrefHelper.getBool(CacheConstants.signInWithGoogle);
      final isBiometric =
      await SharedPrefHelper.getBool(CacheConstants.isBiometricLogin);

      if (isGoogle) {
        await _authRepo.signOutGoogle();
      } else if (!isBiometric) {
        // Email/password — call logout endpoint
        // Even if it fails we still clear local data below
        await _authRepo.logout();
      }
      // Biometric — no server call needed

      await _clearAllLocalData();
      emit(const LogoutSuccess());
    } catch (_) {
      // Always clear local data even on error
      await _clearAllLocalData();
      emit(const LogoutSuccess());
    }
  }

  Future<void> _clearAllLocalData() async {
    await SharedPrefHelper.clearAllSecuredData();
    await SharedPrefHelper.removeData(CacheConstants.userEmail);
    await SharedPrefHelper.removeData(CacheConstants.userEmailFromGoogle);
    await SharedPrefHelper.removeData(CacheConstants.userName);
    await SharedPrefHelper.removeData(CacheConstants.userPhotoUrl);
    await SharedPrefHelper.removeData(CacheConstants.signInWithGoogle);
    await SharedPrefHelper.removeData(CacheConstants.isBiometricLogin);
  }
}