import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constant/cache_constants.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/app_theme.dart';

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
          initialRoute: isFirstLaunch
              ? Routes.onBoardingScreen
              : isBiometric
              ? Routes.homeScreen
              : Routes.loginScreen,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
