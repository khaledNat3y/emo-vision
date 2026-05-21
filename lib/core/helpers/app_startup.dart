import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/flavor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:facial_emotional_detection_graduation_project/firebase_options.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String accessToken = await SharedPrefHelper.getSecuredString(
    CacheConstants.accessToken,
  );
  Logger.debug(accessToken);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupDependencies();

  await ScreenUtil.ensureScreenSize();

  Logger.debug(AppConfig.modeName);

  await checkIfUserFirstLaunch();
}

Future<void> checkIfUserFirstLaunch() async {
  final hasSeenOnboarding = await SharedPrefHelper.getBool(
    CacheConstants.hasSeenOnboarding,
  );
  final isBiometricLoggedIn = await SharedPrefHelper.getBool(
    CacheConstants.isBiometricLogin,
  );
  final loggedInWithGoogle = await SharedPrefHelper.getBool(
    CacheConstants.signInWithGoogle,
  );
  final String accessToken = await SharedPrefHelper.getSecuredString(
    CacheConstants.accessToken,
  );

  isFirstLaunch = !hasSeenOnboarding;
  if (isBiometricLoggedIn) isBiometric = true;
  if (loggedInWithGoogle) isUserLoggedInWithGoogle = true;
  if (accessToken.isNotEmpty) {
    isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken = true;
  }

  Logger.debug("isFirstLaunch: $isFirstLaunch");
  Logger.debug("isBiometric: $isBiometric");
  Logger.debug("isUserLoggedInWithGoogle: $isUserLoggedInWithGoogle");
  Logger.debug(
    "isUserLoggedInWithEmailAndPassword: $isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken",
  );
}
