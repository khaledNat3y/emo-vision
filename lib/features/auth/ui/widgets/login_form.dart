import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../data/models/login_request_body.dart';
import 'custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isChecked = false;
  late TextEditingController passwordController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // passwordController = context.read<LoginCubit>().passwordController;
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Email", style: Theme.of(context).textTheme.titleSmall),
            5.verticalSpace,
            AppTextFormField(
              controller: emailController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-5, 0),
                      // Move checkbox slightly left to align better
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        },
                        activeColor: AppColors.primary,
                        checkColor: AppColors.white,
                        side: const BorderSide(
                          color: AppColors.grey,
                          width: 1.5,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // Reduces padding
                        visualDensity:
                            VisualDensity.compact, // Makes it more compact
                      ),
                    ),
                    Text("Remember me", style: AppTextTheme.font12GreyMedium),
                  ],
                ),
                GestureDetector(
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: AppColors.primary),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            16.verticalSpace,
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomButton(
                  text: 'Log in',
                  isLoading: state is LoginLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                        body: LoginRequestBody(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            LoginBlocListener(email: emailController.text,),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
