import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

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

      // ── Case 1: Fresh navigation from login (args provided) ──────────────
      // Args are passed when navigating directly from login screen.
      // On hot reload args become null — fall through to Case 2.
      final hasArgs =
          (userNameFromArgs != null && userNameFromArgs.isNotEmpty) ||
          (emailFromArgs != null && emailFromArgs.isNotEmpty);

      if (hasArgs) {
        displayName = userNameFromArgs ?? '';
        displayEmail = emailFromArgs ?? '';
        photoUrl = photoUrlFromArgs ?? '';
        isBiometric = loginMethod == 'biometric';
      } else {
        // ── Case 2: App restarted or hot reload — read from storage ─────────
        final isGoogle = await SharedPrefHelper.getBool(
          CacheConstants.signInWithGoogle,
        );
        final isBiometricStored = await SharedPrefHelper.getBool(
          CacheConstants.isBiometricLogin,
        );

        isBiometric = isBiometricStored;

        if (isGoogle) {
          // Google stores email under userEmailFromGoogle key
          displayEmail =
              await SharedPrefHelper.getString(
                CacheConstants.userEmailFromGoogle,
              ) ??
              '';
          // Google stores name under userName key (set in LoginCubit.signInWithGoogle)
          displayName =
              await SharedPrefHelper.getString(CacheConstants.userName) ?? '';
          photoUrl =
              await SharedPrefHelper.getString(CacheConstants.userPhotoUrl) ??
              '';
        } else if (isBiometricStored) {
          // Biometric reuses whatever email/name was stored from original login
          displayEmail =
              await SharedPrefHelper.getString(CacheConstants.userEmail) ?? '';
          displayName =
              await SharedPrefHelper.getString(CacheConstants.userName) ?? '';
        } else {
          // Email/Password — stored by LoginCubit after /me call
          displayEmail =
              await SharedPrefHelper.getString(CacheConstants.userEmail) ?? '';
          displayName =
              await SharedPrefHelper.getString(CacheConstants.userName) ?? '';
        }
      }

      // Resolve display name
      // Never show the full email as the display name to avoid overflow
      final String resolvedName;
      if (isBiometric) {
        resolvedName = 'Biometric User';
      } else if (displayName.isNotEmpty) {
        resolvedName = displayName;
      } else if (displayEmail.isNotEmpty) {
        // Use only the part before @ to avoid overflow
        resolvedName = displayEmail.split('@').first;
      } else {
        resolvedName = 'User';
      }

      emit(
        HomeSuccess(
          email: displayEmail,
          userName: resolvedName,
          photoUrl: photoUrl,
          isBiometric: isBiometric,
        ),
      );
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }
}
