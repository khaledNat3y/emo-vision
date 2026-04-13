import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/theming/app_colors.dart';
import 'firebase_options.dart';

// These are read once at startup in checkIfUserFirstLaunch()
// and used in EmovisionApp to decide the initial route.
bool isFirstLaunch = false;
bool isBiometric = false;
bool isUserLoggedInWithGoogle = false;
bool isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String accessToken = await SharedPrefHelper.getSecuredString(
    CacheConstants.accessToken,
  );
  Logger.debug(accessToken);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupDependencies();

  await ScreenUtil.ensureScreenSize();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.white.withValues(alpha: 0.05),
    ),
  );

  await checkIfUserFirstLaunch();

  runApp(const EmovisionApp());
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
  final String? accessToken = await SharedPrefHelper.getSecuredString(
    CacheConstants.accessToken,
  );

  Logger.debug("hasSeenOnboarding: $hasSeenOnboarding");

  isFirstLaunch = !hasSeenOnboarding;

  if (isBiometricLoggedIn) {
    isBiometric = true;
  }

  if (loggedInWithGoogle) {
    isUserLoggedInWithGoogle = true;
  }

  if (accessToken != null && accessToken.isNotEmpty) {
    isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken = true;
  }

  Logger.debug("isFirstLaunch: $isFirstLaunch");
  Logger.debug("isBiometric: $isBiometric");
  Logger.debug("isUserLoggedInWithGoogle: $isUserLoggedInWithGoogle");
  Logger.debug(
    "isUserLoggedInWithEmailAndPassword: $isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken",
  );
}
