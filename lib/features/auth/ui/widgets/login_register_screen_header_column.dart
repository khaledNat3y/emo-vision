import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dont_have_already_have_account_widget.dart';
import 'login_logo_and_app_name.dart';

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({
    super.key,});

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
          Text('Sign in to your Account', style: Theme.of(context).textTheme.headlineLarge),
          8.verticalSpace,
          const DontHaveAlreadyHaveAccountWidget(title: "Don't have an account?", subtitle: "Sign Up",),
        ],
      ),
    );
  }
}