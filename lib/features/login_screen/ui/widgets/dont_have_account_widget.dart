import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/font_weight_helper.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        TextSpan(
          text: "Don't have an account? ",
          style: Theme.of(context).textTheme.titleSmall,
          children: [
            TextSpan(
              text: "Sign up",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.semiBold,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primary,
                decorationThickness: 2,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(Routes.signupScreen);
                },
            ),
          ],
        )
    );
  }
}
