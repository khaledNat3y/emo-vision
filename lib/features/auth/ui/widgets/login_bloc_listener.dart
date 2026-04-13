import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  final Widget child;

  const LoginBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          FocusScope.of(context).unfocus();
          Future.microtask(() {
            if (context.mounted) {
              context.pushNamedAndRemoveUntil(
                Routes.homeScreen,
                arguments: {
                  'email': state.email,
                  'userName': state.userName,
                  'photoUrl': '',
                  'loginMethod': 'email',
                },
                predicate: (route) => false,
              );
            }
          });
        }

        if (state is LoginWithGoogleSuccess) {
          FocusScope.of(context).unfocus();
          Future.microtask(() {
            if (context.mounted) {
              context.pushNamedAndRemoveUntil(
                Routes.homeScreen,
                arguments: {
                  'email': state.email,
                  'userName': state.userName,
                  'photoUrl': state.photoUrl,
                  'loginMethod': 'google',
                },
                predicate: (route) => false,
              );
            }
          });
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: child,
    );
  }
}