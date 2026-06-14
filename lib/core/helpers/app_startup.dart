import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart'
    as Firebase;
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_client.dart';
import 'package:facial_emotional_detection_graduation_project/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> initialize() async {
  await SupabaseClientHelper.initialize();

  setupDependencies();

  await ScreenUtil.ensureScreenSize();

  await checkIfUserFirstLaunch();
}

Future<void> checkIfUserFirstLaunch() async {
  final hasSeenOnboarding = await SharedPrefHelper.getBool(
    CacheConstants.hasSeenOnboarding,
  );
  Logger.debug('Has seen onboarding: $hasSeenOnboarding');
  final isBiometricLoggedIn = await SharedPrefHelper.getBool(
    CacheConstants.isBiometricLogin,
  );
  Logger.debug('Is biometric login: $isBiometricLoggedIn');

  isFirstLaunch = !hasSeenOnboarding;
  if (isBiometricLoggedIn) isBiometric = true;
  isUserLoggedIn = SupabaseAuthService().client.auth.currentUser != null;
  Logger.debug('Is user logged in: $isUserLoggedIn');
}
