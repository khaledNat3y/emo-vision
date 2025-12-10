import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/functions.dart';
import '../../logic/login_cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showEnhancedDialog(
            context: context,
            isError: true,
            data: state.error,
          );
        }else if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
        }
      },
      child: const SizedBox.shrink(),
    );
  }


}

