import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/custom_btn.dart';
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
  late final TextEditingController _otpController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F8),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
                      color: Color(0xFF1565C0),
                    ),
                    Text(
                      'Security',
                      style: TextStyle(
                        color: const Color(0xFF1565C0),
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
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              8.verticalSpace,
              Text(
                'Enter the OTP sent to your email and your new\npassword to secure your account.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF888888),
                  height: 1.5,
                ),
              ),
              28.verticalSpace,
              Text('EMAIL ADDRESS', style: AppTextTheme.font12GreyMedium),
              8.verticalSpace,
              AppTextFormField(
                controller: TextEditingController(text: widget.email),
                isReadOnly: true,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF1565C0),
                ),
                validator: (value) => null,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VERIFICATION CODE',
                    style: AppTextTheme.font12GreyMedium,
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
                        context.read<ForgotPasswordCubit>().startResendTimer();
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
                                ? const Color(0xFF888888)
                                : const Color(0xFF1565C0),
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
                onCompleted: _handleVerifyOTP,
              ),
              20.verticalSpace,
              Text("NEW PASSWORD", style: AppTextTheme.font12GreyMedium),
              8.verticalSpace,
              AppTextFormField(
                controller: _newPasswordController,
                hintText: '••••••••',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              Text(
                "CONFIRM NEW PASSWORD",
                style: AppTextTheme.font12GreyMedium,
              ),
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
                        backgroundColor: Colors.green,
                      ),
                    );
                    context.pop();
                  } else if (state is ResetPasswordError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomBtn(
                    title: state is ResetPasswordLoading
                        ? "Verifying..."
                        : "Reset Password",
                    onTap: _handleVerifyOTP,
                    isLoading: false,
                  );
                },
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _handleVerifyOTP() {
    if (!mounted) return;
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete 6-digit code'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
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
