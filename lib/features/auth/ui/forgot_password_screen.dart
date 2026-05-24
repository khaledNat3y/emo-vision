import 'package:facial_emotional_detection_graduation_project/core/helpers/app_regex.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_state.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: theme.textTheme.displayMedium?.copyWith(fontSize: 24),
                ),
                verticalSpace(6),
                Text(
                  "Enter your email address to receive a password reset link.",
                  style: theme.textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(50),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: theme.textTheme.titleSmall,
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
                      context.pushNamedAndRemoveUntil(
                        Routes.loginScreen,
                        predicate: (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: state is ForgotPasswordLoading
                          ? "Loading..."
                          : "Send Reset Link",
                      isLoading: state is ForgotPasswordLoading,
                      onPressed: state is ForgotPasswordLoading
                          ? null
                          : () => _sendResetLink(),
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
                    style: theme.textTheme.bodyMedium?.copyWith(
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

  void _sendResetLink() async {
    if (formKey.currentState!.validate() &&
        AppRegex.isEmailValid(emailController.text)) {
      await context
          .read<ForgotPasswordCubit>()
          .forgotPassword(emailController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  String? _validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter valid email";
    }
    return null;
  }
}