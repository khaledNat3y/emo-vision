import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/supabase/supabase_client.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  await initializeApp();
  await SupabaseClientHelper.initialize();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://f6469697cbeae7bf9bd0c4b82ab45a61@o4511396118659072.ingest.us.sentry.io/4511396142710784';
    // Adds request headers and IP for users, for more info visit:
    // https://docs.sentry.io/platforms/dart/guides/flutter/data-management/data-collected/
    options.sendDefaultPii = true;
  }, appRunner: () => runApp(const EmoVisionApp()));
}
