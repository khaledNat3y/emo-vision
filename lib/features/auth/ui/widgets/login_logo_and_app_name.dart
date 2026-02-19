import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_assets.dart';

class LoginLogoAndAppName extends StatelessWidget {
  final String? title;
  const LoginLogoAndAppName({
    super.key, this.title = 'EmoVision',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppAssets.appLogo, width: 25.w,),
        5.horizontalSpace,
        Text(
          title!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
