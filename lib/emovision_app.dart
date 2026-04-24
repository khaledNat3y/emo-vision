import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart'; // ✅ add this
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/app_router.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_theme.dart';

class EmovisionApp extends StatelessWidget {
  const EmovisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EmoVision',
          theme: AppTheme.lightMode,
          darkTheme: AppTheme.darkMode,
          themeMode: ThemeMode.light,
          initialRoute: _resolveInitialRoute(),
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }

  String _resolveInitialRoute() {
    // First launch — show onboarding
    if (isFirstLaunch) return Routes.onBoardingScreen;

    // Biometric — show biometric screen to re-authenticate
    // (NOT home directly — user must pass fingerprint first)
    if (isBiometric) return Routes.biometricLoginScreen;

    // Google or Email/Password with valid token — go straight to home
    if (isUserLoggedInWithGoogle) return Routes.homeScreen;
    if (isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken) {
      return Routes.homeScreen;
    }

    // Default — login screen
    return Routes.loginScreen;
  }
}
