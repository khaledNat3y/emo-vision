import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dont_have_already_have_account_widget.dart';

class RegisterScreenHeader extends StatelessWidget {
  const RegisterScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          IconButton(onPressed: (){
            context.pop();
          }, icon: const Icon(Icons.arrow_back, color: AppColors.white, size: 24,)),
          30.verticalSpace,
          Text('Register', style: Theme.of(context).textTheme.headlineLarge),
          8.verticalSpace,
          const DontHaveAlreadyHaveAccountWidget(title: "Already have an account?", subtitle: "Log in",),
        ],
      ),
    );
  }
}
