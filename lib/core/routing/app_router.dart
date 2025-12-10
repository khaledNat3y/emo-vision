import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/router_transitions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/register_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/onboarding/ui/onboarding_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    // this arguments to be passed in any screen like this (arguments as ClassName)
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return RouterTransitions.buildFade(BlocProvider(
          create: (context) => LoginCubit(getIt<AuthRepo>()),
          child: const LoginScreen(),
        ),);
      case Routes.registerScreen:
        return RouterTransitions.buildFade( BlocProvider(
          create: (context) => RegisterCubit(getIt<AuthRepo>()),
          child: const RegisterScreen(),
        ),);
      case Routes.homeScreen:
        return RouterTransitions.buildFade( BlocProvider(
          create: (context) => LoginCubit(getIt<AuthRepo>()),
          child: const HomeScreen(),
        ),);
      default:
        return null;
    }
  }
}