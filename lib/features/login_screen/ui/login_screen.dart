import 'package:facial_emotional_detection_graduation_project/core/helpers/app_assets.dart';
import 'package:facial_emotional_detection_graduation_project/features/login_screen/ui/widgets/login_screen_header_column.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.loginScreenHead),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const LoginScreenHeaderColumn(),
              ],
            ),
          ),
          Expanded(flex: 2, child: Container(color: Colors.blue)),
        ],
      ),
    );
  }
}

