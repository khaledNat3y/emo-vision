import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_client.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/cubit/theme_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:facial_emotional_detection_graduation_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialize();
  final themeCubit = getIt<ThemeCubit>();
  //   await themeCubit.loadTheme();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://f6469697cbeae7bf9bd0c4b82ab45a61@o4511396118659072.ingest.us.sentry.io/4511396142710784';
      // Adds request headers and IP for users, for more info visit:
      // https://docs.sentry.io/platforms/dart/guides/flutter/data-management/data-collected/
      options.sendDefaultPii = true;
    },
    appRunner: () => runApp(
      BlocProvider(
        create: (context) => getIt<ThemeCubit>(),
        child: const EmoVisionApp(),
      ),
    ),
  );
}
