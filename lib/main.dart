import 'package:facial_emotional_detection_graduation_project/emovision_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theming/app_colors.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.white.withValues(alpha: 0.04),
  ));
  runApp(const EmovisionApp());
}

