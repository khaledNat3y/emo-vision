import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/font_weight_helper.dart';

class DontHaveAlreadyHaveAccountWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const DontHaveAlreadyHaveAccountWidget({
    super.key, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.titleSmall,
          children: [
            TextSpan(
              text: subtitle,
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
                  context.pushNamed(Routes.registerScreen);
                },
            ),
          ],
        )
    );
  }
}
