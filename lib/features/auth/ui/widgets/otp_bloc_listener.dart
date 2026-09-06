import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/functions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/otp_cubit/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpBlocListener extends StatelessWidget {
  final Widget child;

  const OtpBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpError) {
          showEnhancedDialog(
            context: context,
            isError: true,
            message: state.error,
          );
        } else if (state is OtpSuccess) {
          FocusScope.of(context).unfocus();
          Future.microtask(() {
            if (context.mounted) {
              context.pushNamedAndRemoveUntil(
                Routes.otpSuccessScreen,
                predicate: (route) => false,
              );
            }
          });
        }
      },
      child: child,
    );
  }
}