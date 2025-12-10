import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/register_form.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/widgets/register_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_assets.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
              const RegisterScreenHeader(),
            ],
          ),
          24.verticalSpace,
          const RegisterForm(),
        ],
      ),
    );
  }
}



