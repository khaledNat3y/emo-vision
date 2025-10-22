import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dont_have_account_widget.dart';
import 'login_logo_and_app_name.dart';

class LoginScreenHeaderColumn extends StatelessWidget {
  const LoginScreenHeaderColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          const LoginLogoAndAppName(),
          32.verticalSpace,
          Text(
            'Sign in to your Account',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          8.verticalSpace,
          const DontHaveAccountWidget(),
        ],
      ),
    );
  }
}
