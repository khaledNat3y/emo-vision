import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theming/app_colors.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.white.withValues(alpha: 0.04),
  ));
  runApp(const EmovisionApp());


}

