import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());
    try {
      final response = await _authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        emit(const LoginError(error: 'Login failed'));
        return;
      }

      await SharedPrefHelper.setData(
        CacheConstants.userEmail,
        user.email ?? '',
      );
      await SharedPrefHelper.setData(
        CacheConstants.userName,
        user.userMetadata?['full_name'] ?? '',
      );
      await SharedPrefHelper.setData(CacheConstants.isUserAuthenticated, true);

      emit(
        LoginSuccess(
          email: user.email ?? '',
          userName: user.userMetadata?['full_name'] ?? '',
        ),
      );
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(const LoginWithGoogleLoading());

    try {
      final AuthResponse response = await _authRepo.signInWithGoogle();

      final user = response.user;

      if (user == null || response.session == null) {
        emit(const LoginError(error: 'Google sign-in failed'));
        return;
      }

      await SharedPrefHelper.setData(
        CacheConstants.userEmail,
        user.email ?? '',
      );

      await SharedPrefHelper.setData(
        CacheConstants.userName,
        user.userMetadata?['full_name'] ?? '',
      );

      await SharedPrefHelper.setData(
        CacheConstants.userPhotoUrl,
        user.userMetadata?['avatar_url'] ?? '',
      );

      emit(
        LoginWithGoogleSuccess(
          email: user.email ?? '',
          userName: user.userMetadata?['full_name'] ?? '',
          photoUrl: user.userMetadata?['avatar_url'] ?? '',
        ),
      );
    } catch (e) {
      Logger.info('Google sign-in error: $e');
      emit(
        const LoginWithGoogleError(
          error: "Google sign-in failed, Please try again",
        ),
      );
    }
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
  }
}
