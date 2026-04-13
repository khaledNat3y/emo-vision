import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import 'dont_have_already_have_account_widget.dart';
import 'login_logo_and_app_name.dart';

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          30.verticalSpace,
          const LoginLogoAndAppName(),
          30.verticalSpace,
          Text(
            'Sign in to your Account',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          8.verticalSpace,
          DontHaveAlreadyHaveAccountWidget(
            title: "Don't have an account?",
            subtitle: "Sign Up",
            onTap: () {
              // Step 1: unfocus all text fields (dismiss keyboard)
              FocusScope.of(context).unfocus();
              // Step 2: delay navigation until after current frame is done
              // This prevents "dirty widget in wrong build scope" crash
              Future.microtask(() {
                if (context.mounted) {
                  context.pushNamed(Routes.registerScreen);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}