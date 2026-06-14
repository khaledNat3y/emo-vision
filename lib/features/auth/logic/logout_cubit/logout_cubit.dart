import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo _authRepo;

  LogoutCubit(this._authRepo) : super(const LogoutInitial());

  Future<void> logout() async {
    emit(const LogoutLoading());
    try {
      await _authRepo.signOut();
      await _clearAllLocalData();
      emit(const LogoutSuccess());
    } catch (_) {
      await _clearAllLocalData();
      emit(const LogoutSuccess());
    }
  }

  Future<void> _clearAllLocalData() async {
    await SharedPrefHelper.clearAllSecuredData();
    await SharedPrefHelper.removeData(CacheConstants.userEmail);
    await SharedPrefHelper.removeData(CacheConstants.userName);
    await SharedPrefHelper.removeData(CacheConstants.userPhotoUrl);
    await SharedPrefHelper.removeData(CacheConstants.isBiometricLogin);
    await SharedPrefHelper.removeData(CacheConstants.isUserAuthenticated);
  }
}
