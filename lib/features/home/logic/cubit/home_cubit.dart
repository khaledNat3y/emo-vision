import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  /// Reads the cached user info from SharedPreferences and emits [HomeSuccess].
  /// This handles all 3 login methods:
  ///   - Email/Password → email + fullName from /api/auth/me
  ///   - Google         → email + displayName + photoUrl from Firebase
  ///   - Biometric      → same email + name that were saved during original login
  Future<void> loadUserInfo({
    String? emailFromArgs,
    String? userNameFromArgs,
    String? photoUrlFromArgs,
    String? loginMethod,
  }) async {
    emit(const HomeLoading());

    try {
      String displayName = '';
      String displayEmail = '';
      String photoUrl = '';
      bool isBiometric = false;

      // If args are provided (fresh navigation from login), use them directly
      if (userNameFromArgs != null && userNameFromArgs.isNotEmpty) {
        displayName = userNameFromArgs;
        displayEmail = emailFromArgs ?? '';
        photoUrl = photoUrlFromArgs ?? '';
        isBiometric = loginMethod == 'biometric';
      } else {
        // App restarted — determine method from stored flags
        final isGoogle = await SharedPrefHelper.getBool(
          CacheConstants.signInWithGoogle,
        );
        final isBiometricStored = await SharedPrefHelper.getBool(
          CacheConstants.isBiometricLogin,
        );

        isBiometric = isBiometricStored;

        if (isGoogle) {
          displayEmail = await SharedPrefHelper.getString(
            CacheConstants.userEmailFromGoogle,
          );
          displayName = await SharedPrefHelper.getString(
            CacheConstants.userName,
          );
          photoUrl = await SharedPrefHelper.getString(
            CacheConstants.userPhotoUrl,
          );
        } else if (isBiometricStored) {
          // Biometric reuses the last email/name that was stored
          displayEmail = await SharedPrefHelper.getString(
            CacheConstants.userEmail,
          );
          displayName = await SharedPrefHelper.getString(
            CacheConstants.userName,
          );
        } else {
          // Email/Password
          displayEmail = await SharedPrefHelper.getString(
            CacheConstants.userEmail,
          );
          displayName = await SharedPrefHelper.getString(
            CacheConstants.userName,
          );
        }
      }

      emit(
        HomeSuccess(
          email: displayEmail,
          userName: isBiometric
              ? 'Biometric User'
              : displayName.isNotEmpty
              ? displayName
              : displayEmail,
          photoUrl: photoUrl,
          isBiometric: isBiometric,
        ),
      );
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }
}
