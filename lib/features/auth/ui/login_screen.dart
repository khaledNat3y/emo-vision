import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const Scaffold(body: LoginBlocListener(child: LoginScreenBody())),
    );
  }
}
