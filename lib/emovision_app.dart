import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/deep_link_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/cubit/theme_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/app_router.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_theme.dart';

class EmoVisionApp extends StatefulWidget {
  const EmoVisionApp({super.key});

  @override
  State<EmoVisionApp> createState() => _EmoVisionAppState();
}

class _EmoVisionAppState extends State<EmoVisionApp> {
  @override
  void initState() {
    super.initState();
    DeepLinkService.init(navigatorKey);
  }

  @override
  void dispose() {
    DeepLinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.debug(AppConfig.modeName);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: 'EmoVision',
              theme: AppTheme.lightMode,
              darkTheme: AppTheme.darkMode,
              themeMode: themeMode,
              themeAnimationDuration: const Duration(milliseconds: 400),

              // optional animation curve
              themeAnimationCurve: Curves.easeInOut,
              initialRoute: initialRoute(),
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        );
      },
    );
  }

  String initialRoute() {
    if (isFirstLaunch) return Routes.onBoardingScreen;
    if (isBiometric) return Routes.biometricLoginScreen;
    if (isUserLoggedIn) return Routes.homeScreen;
    return Routes.loginScreen;
  }
}
