import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  final HomeSuccess state;
  final VoidCallback onLogoutTap;

  const HomeHeader({super.key, required this.state, required this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _HomeAvatar(state: state),
        _LogoutButton(onTap: onLogoutTap),
      ],
    );
  }
}

class _HomeAvatar extends StatelessWidget {
  final HomeSuccess state;

  const _HomeAvatar({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.15),
            image: state.photoUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(state.photoUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: state.photoUrl.isEmpty
              ? Center(
                  child: Text(
                    state.isBiometric
                        ? '🔒'
                        : state.userName.isNotEmpty
                        ? state.userName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: state.isBiometric ? 20.sp : 18.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.isBiometric ? 'Biometric User' : state.userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (state.email.isNotEmpty && !state.isBiometric)
              Text(state.email, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutCubit, LogoutState>(
      builder: (context, state) {
        final isLoading = state is LogoutLoading;
        return GestureDetector(
          onTap: isLoading ? null : onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: isLoading
                ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.error,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        size: 16.sp,
                        color: AppColors.error,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
