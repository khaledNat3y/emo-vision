import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/cubit/theme_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:facial_emotional_detection_graduation_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialize();
  final token = await SharedPrefHelper.getSecuredString(
    CacheConstants.supabaseAccessToken,
  );
  Logger.info('Supabase token: ${token != null ? "exists" : "not found"}');
  Logger.info(token);
  final themeCubit = getIt<ThemeCubit>();
  await themeCubit.loadTheme();
  runApp(
    BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: const EmoVisionApp(),
    ),
  );
}
