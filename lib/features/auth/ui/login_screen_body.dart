import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/biometric_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_login_method.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/login_form.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/login_register_screen_header_column.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/or_login_with_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_assets.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Header image
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.32389,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.loginScreenHead),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const LoginScreenHeader(),
            ],
          ),

          // Email / Password form
          const LoginForm(),

          const OrLoginWith(),
          16.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google
              CustomLoginMethod(
                iconPath: AppAssets.googleIcon,
                title: 'Google',
                onTap: () {
                  context.read<LoginCubit>().signInWithGoogle();
                },
              ),

              15.horizontalSpace,

              // Biometric
              CustomLoginMethod(
                iconPath: AppAssets.biometric,
                title: 'Biometric',
                onTap: () {
                  BiometricService().authenticate().then((authenticated) {
                    if (authenticated && context.mounted) {
                      Logger.debug('Biometric authenticated: $authenticated');
                      SharedPrefHelper.setData(
                        CacheConstants.isBiometricLogin,
                        true,
                      );
                      // Navigate to home — HomeCubit will detect
                      // isBiometricLogin flag and show "Biometric User"
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.homeScreen,
                      );
                    } else {
                      Logger.debug('Biometric failed or cancelled');
                    }
                  });
                },
              ),
            ],
          ),

          32.verticalSpace,

          // ── Terms text ────────────────────────────────────────────────────
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "By signing up, you agree to the ",
                  style: AppTextTheme.font12GreyMedium,
                  children: [
                    TextSpan(
                      text: "Terms of Service",
                      style: AppTextTheme.font12GreyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: " and \n",
                      style: AppTextTheme.font12GreyMedium,
                    ),
                    TextSpan(
                      text: "Data Processing Agreement",
                      style: AppTextTheme.font12GreyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}
