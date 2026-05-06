import 'package:facial_emotional_detection_graduation_project/core/helpers/app_regex.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/custom_btn.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/password_validation.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/resend_otp_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/reset_password_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/otp_pin_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late GlobalKey<FormState> formKey;
  late final TextEditingController _otpController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late FocusNode _passwordFocusNode;
  // define cubit to access it to get validate variables in the UI
  late ForgotPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
    _otpController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _cubit = context.read<ForgotPasswordCubit>();

    // Listen to password focus changes
    _passwordFocusNode.addListener(() {
      setState(() {
        _cubit.isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });

    // Listen to password text changes for live validation indicators
    _newPasswordController.addListener(() {
      setState(() {
        _cubit.hasLowerCase = AppRegex.hasLowerCase(
          _newPasswordController.text,
        );
        _cubit.hasUpperCase = AppRegex.hasUpperCase(
          _newPasswordController.text,
        );
        _cubit.hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          _newPasswordController.text,
        );
        _cubit.hasNumber = AppRegex.hasNumber(_newPasswordController.text);
        _cubit.hasMinLength = AppRegex.hasMinLength(
          _newPasswordController.text,
        );
      });
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                8.verticalSpace,
                Text(
                  'Enter the OTP sent to your email and your new\npassword to secure your account.',
                  style: theme.textTheme.titleSmall?.copyWith(height: 1.5),
                ),
                28.verticalSpace,
                Text('EMAIL ADDRESS', style: theme.textTheme.titleSmall),
                8.verticalSpace,
                AppTextFormField(
                  controller: TextEditingController(text: widget.email),
                  isReadOnly: true,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.primary,
                  ),
                  validator: (value) => null,
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VERIFICATION CODE',
                      style: theme.textTheme.titleSmall,
                    ),
                    BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state is ResendOtpError) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: Text(state.message),
                              actions: [
                                TextButton(
                                  onPressed: () => context.pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (state is ResendOtpSuccess) {
                          // timer now lives in the cubit
                          context
                              .read<ForgotPasswordCubit>()
                              .startResendTimer();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Success'),
                              content: Text(state.message),
                              actions: [
                                TextButton(
                                  onPressed: () => context.pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final cubit = context.read<ForgotPasswordCubit>();
                        return TextButton(
                          onPressed:
                              cubit.isTimerActive || state is ResendOtpLoading
                              ? null
                              : () {
                                  context.read<ForgotPasswordCubit>().resendOtp(
                                    ResendOtpRequestBody(email: widget.email),
                                  );
                                },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            state is ResendOtpLoading
                                ? 'Resending...'
                                : cubit.isTimerActive
                                ? cubit.timerText
                                : 'Resend OTP',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: cubit.isTimerActive
                                  ? theme.textTheme.titleSmall?.color
                                  : AppColors.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                8.verticalSpace,
                OtpPinField(
                  length: 6,
                  controller: _otpController,
                  onChanged: (value) {
                    if (value.length == 6) {
                      FocusScope.of(context).unfocus();
                    }

                    if (_cubit.otpError != null) {
                      setState(() {
                        _cubit.otpError = null;
                      });
                    }
                  },
                ),
                if (_cubit.otpError != null) ...[
                  verticalSpace(8),
                  Text(
                    _cubit.otpError!,
                    style: TextStyle(color: AppColors.error, fontSize: 12.sp),
                  ),
                ],
                20.verticalSpace,
                Text("NEW PASSWORD", style: theme.textTheme.titleSmall),
                8.verticalSpace,
                AppTextFormField(
                  controller: _newPasswordController,
                  focusNode: _passwordFocusNode,
                  hintText: '••••••••',
                  validator: (value) {
                    if (!_cubit.hasLowerCase ||
                        !_cubit.hasUpperCase ||
                        !_cubit.hasSpecialCharacters ||
                        !_cubit.hasNumber ||
                        !_cubit.hasMinLength) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                16.verticalSpace,
                // Animated Password Validation Indicator
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _cubit.isPasswordFocused
                      ? Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: AnimatedOpacity(
                            opacity: _cubit.isPasswordFocused ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: PasswordValidation(
                              hasLowerCase: _cubit.hasLowerCase,
                              hasUpperCase: _cubit.hasUpperCase,
                              hasSpecialCharacters: _cubit.hasSpecialCharacters,
                              hasNumber: _cubit.hasNumber,
                              hasMinLength: _cubit.hasMinLength,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                16.verticalSpace,
                Text("CONFIRM NEW PASSWORD", style: theme.textTheme.titleSmall),
                8.verticalSpace,
                AppTextFormField(
                  controller: _confirmPasswordController,
                  hintText: '••••••••',
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                40.verticalSpace,
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password reset successful! Please log in with your new password.',
                          ),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      context.pop();
                    } else if (state is ResetPasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomBtn(
                      title: state is ResetPasswordLoading
                          ? "Verifying..."
                          : "Reset Password",
                      onTap: validate,
                      isLoading: false,
                    );
                  },
                ),
                24.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validate() {
    setState(() {
      if (_otpController.text.isEmpty) {
        _cubit.otpError = 'OTP is required';
      } else if (_otpController.text.length != 6) {
        _cubit.otpError = 'OTP must be 6 digits';
      } else {
        _cubit.otpError = null;
      }
    });

    if (formKey.currentState!.validate() && _cubit.otpError == null) {
      context.read<ForgotPasswordCubit>().resetPassword(
        ResetPasswordRequestBody(
          email: widget.email,
          otp: _otpController.text,
          newPassword: _newPasswordController.text,
        ),
      );
    }
  }
}
