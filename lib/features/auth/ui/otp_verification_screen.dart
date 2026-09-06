import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/widgets/custom_btn.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/otp_cubit/otp_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/otp_bloc_listener.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/otp_pin_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerifyOTP() {
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete 6-digit code'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Updated to match new OtpCubit.verifyOTP(email:, otp:) signature
    context.read<OtpCubit>().verifyOTP(
      email: widget.email,
      otp: _otpController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => getIt<OtpCubit>(),
      child: OtpBlocListener(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.grey,
                        size: 20,
                      ),
                    ),
                    32.verticalSpace,

                    // Title
                    Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    8.verticalSpace,

                    // Subtitle with email
                    Text(
                      'We have sent the verification\ncode to ${widget.email}',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.textTheme.titleMedium?.color,
                        height: 1.5,
                      ),
                    ),
                    32.verticalSpace,

                    // OTP Input
                    OtpPinField(
                      length: 6,
                      controller: _otpController,
                      onCompleted: _handleVerifyOTP,
                    ),
                    32.verticalSpace,

                    // Confirm Button
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        return CustomBtn(
                          title: state is OtpLoading
                              ? "Verifying..."
                              : "Confirm",
                          onTap: state is OtpLoading ? null : _handleVerifyOTP,
                          isLoading: state is OtpLoading,
                        );
                      },
                    ),

                    100.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
