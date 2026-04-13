import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class WelcomeMessage extends StatelessWidget {
  final String? userEmail;
  final String? userName;
  final bool isBiometricLogin;
  final bool isGoogleLogin;

  const WelcomeMessage({
    super.key,
    this.userEmail,
    this.userName,
    this.isBiometricLogin = false,
    this.isGoogleLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the display name based on available data
    String displayName;

    if (userName != null && userName!.isNotEmpty) {
      displayName = userName!;
    } else if (userEmail != null && userEmail!.isNotEmpty) {
      // Extract name from email (part before @)
      displayName = userEmail!.split('@').first;
    } else if (isBiometricLogin) {
      displayName = 'Biometric User';
    } else if (isGoogleLogin) {
      displayName = 'Google User';
    } else {
      displayName = 'User';
    }

    return Text(
      'Welcome, $displayName',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}
