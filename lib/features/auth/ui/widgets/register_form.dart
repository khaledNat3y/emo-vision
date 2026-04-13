import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/password_validation.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/app_regex.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/register_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // ── Controllers & Keys ────────────────────────────────────────────────────
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late GlobalKey<FormState> formKey;

  // ── State ─────────────────────────────────────────────────────────────────
  bool isObscureText = true;
  late FocusNode _passwordFocusNode;
  bool _isPasswordFocused = false;
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    formKey = GlobalKey<FormState>();
    _passwordFocusNode = FocusNode();

    // Listen to password focus changes
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });

    // Listen to password text changes for live validation indicators
    password.addListener(() {
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(password.text);
        hasUpperCase = AppRegex.hasUpperCase(password.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(password.text);
        hasNumber = AppRegex.hasNumber(password.text);
        hasMinLength = AppRegex.hasMinLength(password.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── First & Last Name ────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name", style: AppTextTheme.font12GreyMedium),
                      AppTextFormField(
                        hintText: "Lois",
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                24.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Last Name", style: AppTextTheme.font12GreyMedium),
                      AppTextFormField(
                        hintText: "Becket",
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            24.verticalSpace,

            // ── Email ────────────────────────────────────────────────────────
            Text("Email", style: AppTextTheme.font12GreyMedium),
            AppTextFormField(
              hintText: "Loisbecket@gmail.com",
              controller: email,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isEmailValid(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            24.verticalSpace,

            // ── Password ─────────────────────────────────────────────────────
            Text("Password", style: AppTextTheme.font12GreyMedium),
            AppTextFormField(
              hintText: "Password",
              controller: password,
              focusNode: _passwordFocusNode,
              isObscureText: isObscureText,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                icon: isObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                color: AppColors.grey,
              ),
              validator: (value) {
                if (!hasLowerCase ||
                    !hasUpperCase ||
                    !hasSpecialCharacters ||
                    !hasNumber ||
                    !hasMinLength) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),

            // ── Animated Password Validation Indicator ───────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isPasswordFocused
                  ? Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: AnimatedOpacity(
                  opacity: _isPasswordFocused ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: PasswordValidation(
                    hasLowerCase: hasLowerCase,
                    hasUpperCase: hasUpperCase,
                    hasSpecialCharacters: hasSpecialCharacters,
                    hasNumber: hasNumber,
                    hasMinLength: hasMinLength,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),

            24.verticalSpace,

            // ── Confirm Password ─────────────────────────────────────────────
            Text("Confirm Password", style: AppTextTheme.font12GreyMedium),
            AppTextFormField(
              hintText: "Confirm Password",
              controller: confirmPassword,
              isObscureText: isObscureText,
              validator: (value) {
                if (value != password.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            55.verticalSpace,

            // ── Register Button ───────────────────────────────────────────────
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Register",
                  isLoading: state is RegisterLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().register(
                        body: RegisterRequestBody(
                          email: email.text,
                          password: password.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        ),
                      );
                    }
                  },
                );
              },
            ),

            // ✅ RegisterBlocListener is NOT here.
            // It wraps the entire RegisterScreenBody inside RegisterScreen.
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}