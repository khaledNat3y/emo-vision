import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/biometric_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/custom_login_method.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/login_form.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/login_register_screen_header_column.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/or_login_with_widget.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_assets.dart';
import '../../../core/theming/app_colors.dart';
import '../logic/login_cubit/login_cubit.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const LoginForm(),
          const OrLoginWith(),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLoginMethod(
                iconPath: AppAssets.googleIcon,
                title: 'Google',
                onTap: () async {
                  await context.read<LoginCubit>().signInWithGoogle();
                  // await SharedPrefHelper.setData(CacheConstants.signInWithGoogle, true);
                },
              ),
              15.horizontalSpace,
              CustomLoginMethod(
                iconPath: AppAssets.biometric,
                title: 'Biometric',
                onTap: () {
                  BiometricService().requestBiometric().then((value) {
                    if (value) {
                      Logger.debug(value.toString());
                      if (context.mounted) {
                        SharedPrefHelper.setData(
                          CacheConstants.isBiometricLogin,
                          value,
                        );
                        /// navigate to home
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      }
                    }
                    Logger.debug(value.toString());
                  });
                },
              ),
            ],
          ),
          32.verticalSpace,
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
                        color: AppColors.black,
                      ),
                    ),
                    TextSpan(
                      text: " and \n",
                      style: AppTextTheme.font12GreyMedium,
                    ),
                    TextSpan(
                      text: "Data Processing Agreement",
                      style: AppTextTheme.font12GreyMedium.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
