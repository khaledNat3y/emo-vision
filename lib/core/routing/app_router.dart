import 'package:facial_emotional_detection_graduation_project/core/networking/dio_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/firebase_services.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/forgot_password_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/biometric_login_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/login_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/otp_scuccess_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/otp_verification_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/register_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/home_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(
              AuthRepo(AuthService(DioHelper.dio), FirebaseServices()),
            ),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.otpScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OTPVerificationScreen(email: args?['email'] ?? ''),
        );

      case Routes.resetPasswordScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args?['cubit'] as ForgotPasswordCubit,
            child: ResetPasswordScreen(email: args?['email'] ?? ''),
          ),
        );

      case Routes.otpSuccessScreen:
        return MaterialPageRoute(builder: (_) => const OTPSuccessScreen());

      case Routes.biometricLoginScreen:
        return MaterialPageRoute(builder: (_) => const BiometricLoginScreen());

      case Routes.homeScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            email: args?['email'],
            userName: args?['userName'],
            photoUrl: args?['photoUrl'],
            loginMethod: args?['loginMethod'],
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
