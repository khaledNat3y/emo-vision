import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeApp();
  final token = await SharedPrefHelper.getSecuredString(
    CacheConstants.supabaseAccessToken,
  );
  Logger.info('Supabase token: ${token != null ? "exists" : "not found"}');
  Logger.info(token);

  runApp(const EmoVisionApp());
}
