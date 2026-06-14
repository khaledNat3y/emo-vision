import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/update_password_cubit/cubit/update_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/email_verifiedScreen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/forgot_password_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/reset_password_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/update_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/biometric_login_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/login_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/register_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/home_root.dart';
import 'package:facial_emotional_detection_graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.biometricLoginScreen:
        return MaterialPageRoute(builder: (_) => const BiometricLoginScreen());

      case Routes.homeScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => HomeRoot(
            email: args?['email'],
            userName: args?['userName'],
            photoUrl: args?['photoUrl'],
            loginMethod: args?['loginMethod'],
          ),
        );

      case Routes.emailVerifiedScreen:
        return MaterialPageRoute(builder: (_) => const EmailVerifiedScreen());

      case Routes.updatePasswordScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UpdatePasswordCubit>(),
            child: UpdatePasswordScreen(
              // accessToken: args?['access_token'] ?? '',
            ),
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
