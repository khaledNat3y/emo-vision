import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/custom_btn.dart';
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

  bool _obscureNew = true;
  bool _obscureConfirm = true;

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
              // Back button
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

              // Title
              Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              8.verticalSpace,

              // Subtitle
              Text(
                'Enter the OTP sent to your email and your new\npassword to secure your account.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF888888),
                  height: 1.5,
                ),
              ),
              28.verticalSpace,

              // EMAIL ADDRESS label
              Text('EMAIL ADDRESS', style: AppTextTheme.font12GreyMedium),
              8.verticalSpace,

              // Email display card (read-only)
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

              // VERIFICATION CODE label + Resend row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VERIFICATION CODE',
                    style: AppTextTheme.font12GreyMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1565C0),
                      ),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,

              // OTP Input — untouched
              OtpPinField(
                length: 6,
                controller: _otpController,
                onCompleted: _handleVerifyOTP,
              ),
              20.verticalSpace,

              // NEW PASSWORD label
              Text("NEW PASSWORD", style: AppTextTheme.font12GreyMedium),
              8.verticalSpace,

              // New password field
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

              // CONFIRM NEW PASSWORD label
              Text(
                "CONFIRM NEW PASSWORD",
                style: AppTextTheme.font12GreyMedium,
              ),
              8.verticalSpace,

              // Confirm password field
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
