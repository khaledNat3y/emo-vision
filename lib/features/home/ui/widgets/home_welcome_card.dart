import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/home_cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWelcomeCard extends StatelessWidget {
  final HomeSuccess state;

  const HomeWelcomeCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back 👋',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 6.h),
          // userName is always resolved cleanly by HomeCubit
          Text(
            state.userName,
            style: TextStyle(
              fontSize: 22.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          // if (state.isBiometric) ...[
          //   Text(
          //     "Please Signin with email to analyze your emotions",
          //     style: TextStyle(fontSize: 16.sp, color: AppColors.error),
          //   ),
          //   SizedBox(height: 8.h),
          // ],
          _LoginMethodBadge(state: state),
        ],
      ),
    );
  }
}

class _LoginMethodBadge extends StatelessWidget {
  final HomeSuccess state;

  const _LoginMethodBadge({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 14.sp, color: AppColors.white),
          SizedBox(width: 6.w),
          Text(
            _label,
            style: TextStyle(fontSize: 12.sp, color: AppColors.white),
          ),
        ],
      ),
    );
  }

  IconData get _icon {
    if (state.isBiometric) return Icons.fingerprint;
    if (state.photoUrl.isNotEmpty) return Icons.g_mobiledata_rounded;
    return Icons.email_outlined;
  }

  String get _label {
    if (state.isBiometric) return 'Biometric Login';
    if (state.photoUrl.isNotEmpty) return 'Google Account';
    return 'Email Login';
  }
}
