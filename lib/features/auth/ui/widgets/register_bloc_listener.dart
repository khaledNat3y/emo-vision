import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/functions.dart';
import '../../../../core/routing/routes.dart';
import '../../logic/register_cubit/register_cubit.dart';

class RegisterBlocListener extends StatelessWidget {
  final String? email;

  const RegisterBlocListener({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (BuildContext context, state) {
        if (state is RegisterError) {
          showEnhancedDialog(
            context: context,
            isError: true,
            data: state.error,
          );
        } else if (state is RegisterSuccess) {
          context.pushNamedAndRemoveUntil(
            Routes.otpScreen,
            predicate: (route) => false,
            arguments: email,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
