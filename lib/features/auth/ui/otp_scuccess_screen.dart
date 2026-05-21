import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/custom_btn.dart';

class OTPSuccessScreen extends StatelessWidget {
  const OTPSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                verticalSpace(60),
                // Success Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2.5),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),
                24.verticalSpace,

                // Success Title
                Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                12.verticalSpace,

                // Success Message
                Text(
                  'Congratulations! You have been\nsuccessfully authenticated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.textTheme.titleMedium?.color,
                    height: 1.5,
                  ),
                ),
                40.verticalSpace,

                // Continue Button
                80.verticalSpace,
                CustomBtn(
                  title: "Continue",
                  onTap: () {
                    context.pushReplacementNamed(Routes.loginScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
