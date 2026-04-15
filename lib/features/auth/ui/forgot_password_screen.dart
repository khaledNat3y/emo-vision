import 'package:facial_emotional_detection_graduation_project/core/helpers/app_regex.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/otp_verification_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Forgot Password", style: AppTextTheme.font24BlackBold),
              verticalSpace(6),
              Text(
                "Enter your email address to receive a password reset link.",
                style: AppTextTheme.font12GreyMedium,
                textAlign: TextAlign.center,
              ),
              verticalSpace(50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address",
                  style: AppTextTheme.font12GreyMedium.copyWith(
                    fontWeight: FontWeightHelper.regular,
                    fontSize: 12,
                  ),
                ),
              ),
              verticalSpace(6),
              AppTextFormField(
                controller: emailController,
                hintText: "example@gmail.com",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter valid email";
                  }
                },
              ),
              verticalSpace(32),
              CustomButton(text: "Get Reset OTP", onPressed: _login),
              verticalSpace(32),
              TextButton(
                onPressed: () {
                  context.pushReplacementNamed(Routes.loginScreen);
                },
                child: Text(
                  "Back to Login",
                  style: AppTextTheme.font13WhiteRegular.copyWith(
                    color: AppColors.primary,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid email"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    } else if (!AppRegex.isEmailValid(emailController.text)) {
      // tell user the words he must write to be a suitable for regex
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email should be like this name@gmail.com"),
          backgroundColor: AppColors.error,
        ),
      );
    } else {}
  }
}
