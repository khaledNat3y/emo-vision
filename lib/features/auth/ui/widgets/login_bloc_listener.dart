import 'package:dartz/dartz.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/cache_constants.dart';
import '../../../../core/helpers/functions.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../logic/login_cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  final String email;
  const LoginBlocListener({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async{
        if (state is LoginError) {
          showEnhancedDialog(
            context: context,
            isError: true,
            data: state.error,
          );
          await SharedPrefHelper.setData(CacheConstants.signInWithGoogle, false);
        } else if (state is LoginSuccess) {
          await SharedPrefHelper.setData(CacheConstants.userEmail, email);
          if(context.mounted) context.pushReplacementNamed(Routes.homeScreen, arguments: email);
        }else if (state is LoginWithGoogleLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logging in with Google...')),
          );
        }else if (state is LoginWithGoogleSuccess) {
          await SharedPrefHelper.setData(CacheConstants.signInWithGoogle, true);
          await SharedPrefHelper.setData(CacheConstants.userEmailFromGoogle, state.email);
          if(context.mounted) context.pushReplacementNamed(Routes.homeScreen, arguments: state.email);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}