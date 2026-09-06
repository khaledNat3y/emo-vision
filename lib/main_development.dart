import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/supabase/supabase_client.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await initializeApp();
  await SupabaseClientHelper.initialize();

  runApp(const EmoVisionApp());
}
