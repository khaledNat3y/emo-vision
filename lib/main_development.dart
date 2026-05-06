import 'package:facial_emotional_detection_graduation_project/core/helpers/app_startup.dart';
import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeApp();
  runApp(const EmoVisionApp());
}
