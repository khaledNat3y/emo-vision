import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/biometric_service.dart';

/// Shown when the user previously logged in with biometric.
/// Re-authenticates with fingerprint/face ID, then navigates to home.
class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  bool _isAuthenticating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Auto-trigger biometric prompt on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
    });

    try {
      final biometricService = getIt<BiometricService>();
      final bool authenticated = await biometricService.authenticate();

      if (!mounted) return;

      if (authenticated) {
        // Read cached user info (stored during original email/password login)
        final email = await SharedPrefHelper.getString(
          CacheConstants.userEmail,
        );
        final userName = await SharedPrefHelper.getString(
          CacheConstants.userName,
        );

        if (!mounted) return;

        context.pushNamedAndRemoveUntil(
          Routes.homeScreen,
          arguments: {
            'email': email,
            'userName': userName,
            'photoUrl': '',
            'loginMethod': 'biometric',
          },
          predicate: (route) => false,
        );
      } else {
        setState(() {
          _errorMessage = 'Authentication failed. Please try again.';
          _isAuthenticating = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Biometric error: ${e.toString()}';
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.fingerprint,
                    size: 52.sp,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 28.h),

                Text(
                  'Biometric Login',
                  style: AppTextTheme.font24BlackBold,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10.h),

                Text(
                  'Use your fingerprint or face ID\nto access your account',
                  style: AppTextTheme.font13BlackRegular,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40.h),

                // Loading or error state
                if (_isAuthenticating)
                  Column(
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(height: 16.h),
                      Text(
                        'Authenticating...',
                        style: AppTextTheme.font12GreyMedium,
                      ),
                    ],
                  )
                else ...[
                  if (_errorMessage != null) ...[
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],

                  // Retry button
                  GestureDetector(
                    onTap: _authenticate,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.fingerprint,
                            color: AppColors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Try Again',
                            style: AppTextTheme.font16WhiteMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 24.h),

                // Fallback to login screen
                TextButton(
                  onPressed: () {
                    context.pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      predicate: (route) => false,
                    );
                  },
                  child: Text(
                    'Use another login method',
                    style: AppTextTheme.font12BlueRegular,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
