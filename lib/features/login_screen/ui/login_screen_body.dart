import 'package:facial_emotional_detection_graduation_project/features/login_screen/ui/widgets/login_form.dart';
import 'package:facial_emotional_detection_graduation_project/features/login_screen/ui/widgets/login_screen_header_column.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/app_assets.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.32389,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.loginScreenHead),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const LoginScreenHeaderColumn(),
            ],
          ),
          const LoginForm(),
        ],
      ),
    );
  }
}
