import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/router_transitions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/otp_cubit/otp_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/otp_scuccess_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/otp_verification_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/register_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/onboarding/ui/onboarding_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    // Extract arguments to be passed to screens
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );

      case Routes.loginScreen:
        return RouterTransitions.buildFade(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.registerScreen:
        return RouterTransitions.buildFade(
          BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );

      case Routes.homeScreen:
        final email = arguments as String?;
        return RouterTransitions.buildFade(
          HomeScreen(email: email,),
        );

      case Routes.otpScreen:
      // Get email from arguments
        final email = arguments as String?;

        // Validate that email was passed
        if (email == null || email.isEmpty) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(
                child: Text(
                  'Email is required for verification',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        }

        return RouterTransitions.buildFade(
          BlocProvider(
            create: (context) => getIt<OtpCubit>(),
            child: OTPVerificationScreen(email: email),
          ),
        );

      case Routes.otpSuccessScreen:
        return RouterTransitions.buildFade(
          const OTPSuccessScreen(),
        );

      default:
        return null;
    }
  }
}