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

      final hasArgs =
          (userNameFromArgs != null && userNameFromArgs.isNotEmpty) ||
          (emailFromArgs != null && emailFromArgs.isNotEmpty);

      if (hasArgs) {
        displayName = userNameFromArgs ?? '';
        displayEmail = emailFromArgs ?? '';
        photoUrl = photoUrlFromArgs ?? '';
        isBiometric = loginMethod == 'biometric';
      } else {
        final isBiometricStored = await SharedPrefHelper.getBool(
          CacheConstants.isBiometricLogin,
        );

        isBiometric = isBiometricStored;

        if (isBiometricStored) {
          displayEmail =
              await SharedPrefHelper.getString(CacheConstants.userEmail) ?? '';
          displayName =
              await SharedPrefHelper.getString(CacheConstants.userName) ?? '';
        } else {
          displayEmail =
              await SharedPrefHelper.getString(CacheConstants.userEmail) ?? '';
          displayName =
              await SharedPrefHelper.getString(CacheConstants.userName) ?? '';
        }
      }

      final String resolvedName;
      if (isBiometric) {
        resolvedName = 'Biometric User';
      } else if (displayName.isNotEmpty) {
        resolvedName = displayName;
      } else if (displayEmail.isNotEmpty) {
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