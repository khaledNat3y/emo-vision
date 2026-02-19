import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/api_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/functions.dart';
import '../../logic/otp_cubit/otp_cubit.dart';

class OtpBlocListener extends StatelessWidget {
  const OtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (BuildContext context, state) {
        if (state is OtpError) {
          // Convert OtpErrorModel to ApiErrorModel
          final apiErrorModel = ApiErrorModel(
            statusCode: state.error.statusCode,
            message: state.error.message,
            errors: state.error.errors.otp, // Pass the list of OTP errors
            icon: Icons.error_outline, // You can customize this icon
          );

          showEnhancedDialog(
            context: context,
            isError: true,
            data: apiErrorModel,
          );
        } else if (state is OtpSuccess) {
          // Navigate to success screen
          context.pushNamedAndRemoveUntil(
            Routes.otpSuccessScreen,
            predicate: (route) => false,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}