import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/otp_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/verify_email_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helpers/shared_pref_helper.dart';
import 'core/theming/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String accessToken = await SharedPrefHelper.getSecuredString(CacheConstants.accessToken);
  Logger.debug(accessToken);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.white.withValues(alpha: 0.05),
  ));
  await checkIfUserFirstLaunch();
  runApp(const EmovisionApp());
}


Future<void> checkIfUserFirstLaunch() async {
  final hasSeenOnboarding = await SharedPrefHelper.getBool(CacheConstants.hasSeenOnboarding);
  final isBiometricLoggedIn = await SharedPrefHelper.getBool(CacheConstants.isBiometricLogin);
  final loggedInWithGoogle = await SharedPrefHelper.getBool(CacheConstants.signInWithGoogle);
  Logger.debug("hasSeenOnboarding: $hasSeenOnboarding");
  // If false (default), user hasn't seen onboarding
  // If true, user has completed onboarding
  isFirstLaunch = !hasSeenOnboarding;
  if(isBiometricLoggedIn) {
    isBiometric = true;
  }
  if(loggedInWithGoogle) {
    isUserLoggedInWithGoogle = true;
  }
  Logger.debug("isFirstLaunch: $isFirstLaunch");
  Logger.debug("isBiometric: $isBiometric");
  Logger.debug("isUserLoggedInWithGoogle: $isUserLoggedInWithGoogle");
}





