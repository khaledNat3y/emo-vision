import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/functions.dart';
import '../../../../core/routing/routes.dart';
import '../../logic/register_cubit/register_cubit.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

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
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginScreen,
            (route) => false,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
