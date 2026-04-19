import 'package:facial_emotional_detection_graduation_project/core/helpers/app_regex.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
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
          child: Form(
            key: formKey,
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
                  validator: _validateEmailField,
                ),
                verticalSpace(32),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    } else if (state is ForgotPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      // Navigate to OTP verification screen
                      context.pushNamed(
                        Routes.resetPasswordScreen,
                        arguments: emailController.text,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: state is ForgotPasswordLoading
                          ? "Loading..."
                          : "Get Reset OTP",
                      isLoading: state is ForgotPasswordLoading,
                      onPressed: _login,
                    );
                  },
                ),
                verticalSpace(32),
                TextButton(
                  onPressed: () {
                    context.pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      predicate: (route) => false,
                    );
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
      ),
    );
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      if (!AppRegex.isEmailValid(emailController.text)) {
        // tell user the words he must write to be a suitable for regex
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Email should be like this ${emailController.text}@gmail.com",
            ),
            backgroundColor: AppColors.error,
          ),
        );
      } else {
        // Call cubit to send OTP to user email
        await context.read<ForgotPasswordCubit>().forgotPassword(
          emailController.text,
        );
      }
    }
  }

  dynamic _validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter valid email";
    }
    return null;
  }
}
