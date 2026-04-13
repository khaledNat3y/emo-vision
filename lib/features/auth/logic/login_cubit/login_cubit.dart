import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/login_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(const LoginInitial());

  // ── Email / Password

  Future<void> login({required LoginRequestBody body}) async {
    emit(const LoginLoading());

    final result = await _authRepo.login(body);

    result.fold(
      // Left = error
      (errorMessage) => emit(LoginError(error: errorMessage)),

      // Right = success
      (loginResponse) async {
        // Save tokens securely
        await SharedPrefHelper.setSecuredString(
          CacheConstants.accessToken,
          loginResponse.accessToken,
        );
        await SharedPrefHelper.setSecuredString(
          CacheConstants.refreshToken,
          loginResponse.refreshToken,
        );

        // 2. Fetch user info from /api/auth/me
        final meResult = await _authRepo.getMe();

        meResult.fold(
          // /me failed — fallback to email from request body
          (_) async {
            await SharedPrefHelper.setData(
              CacheConstants.userEmail,
              body.email,
            );
            await SharedPrefHelper.setData(CacheConstants.userName, '');
            emit(LoginSuccess(email: body.email, userName: ''));
          },
          // /me success — cache fullName & email
          (meResponse) async {
            await SharedPrefHelper.setData(
              CacheConstants.userEmail,
              meResponse.email,
            );
            await SharedPrefHelper.setData(
              CacheConstants.userName,
              meResponse.fullName,
            );
            emit(
              LoginSuccess(
                email: meResponse.email,
                userName: meResponse.fullName,
              ),
            );
          },
        );
      },
    );
  }

  // ── Google ─────────────────────────────────────────────────────────────────

  Future<void> signInWithGoogle() async {
    emit(const LoginWithGoogleLoading());

    final result = await _authRepo.signInWithGoogle();

    result.fold((errorMessage) => emit(LoginError(error: errorMessage)), (
      userCredential,
    ) async {
      final user = userCredential.user;
      if (user == null) {
        emit(const LoginError(error: 'Google sign-in failed'));
        return;
      }

      final email = user.email ?? '';
      final userName = user.displayName ?? '';
      final photoUrl = user.photoURL ?? '';

      await SharedPrefHelper.setData(CacheConstants.userEmailFromGoogle, email);
      await SharedPrefHelper.setData(CacheConstants.userName, userName);
      await SharedPrefHelper.setData(CacheConstants.userPhotoUrl, photoUrl);
      await SharedPrefHelper.setData(CacheConstants.signInWithGoogle, true);

      emit(
        LoginWithGoogleSuccess(
          email: email,
          userName: userName,
          photoUrl: photoUrl,
        ),
      );
    });
  }
}
