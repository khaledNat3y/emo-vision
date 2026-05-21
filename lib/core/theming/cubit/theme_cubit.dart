import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> with WidgetsBindingObserver {
  ThemeCubit() : super(_currentSystemThemeMode()) {
    WidgetsBinding.instance.addObserver(this);
    _syncSystemUi(state);
  }

  static ThemeMode _currentSystemThemeMode() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  void didChangePlatformBrightness() {
    final themeMode = _currentSystemThemeMode();
    _syncSystemUi(themeMode);
    emit(themeMode);
  }

  void _syncSystemUi(ThemeMode themeMode) {
    final isDark = themeMode == ThemeMode.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
