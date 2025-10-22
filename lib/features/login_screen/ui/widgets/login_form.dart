import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/password_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    // passwordController = context.read<LoginCubit>().passwordController;
    passwordController = TextEditingController();
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Email", style: Theme.of(context).textTheme.titleSmall),
            5.verticalSpace,
            AppTextFormField(
              hintText: "Loisbecket@gmail.com",
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isEmailValid(value)) {
                  return 'Please enter a valid email';
                }
              },
            ),
            16.verticalSpace,
            Text(" Password", style: Theme.of(context).textTheme.titleSmall),
            5.verticalSpace,
            AppTextFormField(
              controller: passwordController,
              hintText: "*******",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid password';
                }
              },
              isObscureText: isObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                color: AppColors.grey,
              ),
            ),
            16.verticalSpace,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text("Forgot Password?", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.primary)),
                onTap: () {},
              ),
            ),
            PasswordValidation(
              hasLowerCase: hasLowercase,
              hasUpperCase: hasUppercase,
              hasSpecialCharacters: hasSpecialCharacters,
              hasNumber: hasNumber,
              hasMinLength: hasMinLength,
            ),
            16.verticalSpace,
            CustomButton(formKey: formKey, text: 'Log in',)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}

