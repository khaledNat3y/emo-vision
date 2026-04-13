import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_text_theme.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/home_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/analyze_button.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/video_upload_section.dart';

import '../../auth/logic/logout_cubit/logout_cubit.dart';
import '../../auth/logic/logout_cubit/logout_state.dart';
import '../logic/cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  final String? userName;
  final String? photoUrl;
  final String? loginMethod; // 'email' | 'google' | 'biometric'

  const HomeScreen({
    super.key,
    this.email,
    this.userName,
    this.photoUrl,
    this.loginMethod,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedVideo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HomeCubit>()
            ..loadUserInfo(
              emailFromArgs: widget.email,
              userNameFromArgs: widget.userName,
              photoUrlFromArgs: widget.photoUrl,
              loginMethod: widget.loginMethod,
            ),
        ),
        BlocProvider(
          create: (_) => getIt<LogoutCubit>(),
        ),
      ],
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.pushNamedAndRemoveUntil(
              Routes.loginScreen,
              predicate: (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is HomeFailure) {
                  return Center(child: Text(state.error));
                }

                if (state is HomeSuccess) {
                  return _buildBody(context, state);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeSuccess state) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // ── Header Row ─────────────────────────────────────────────────────
          _buildHeader(context, state),

          SizedBox(height: 32.h),

          // ── Welcome Card ───────────────────────────────────────────────────
          _buildWelcomeCard(state),

          SizedBox(height: 32.h),

          // ── Video Upload Section ───────────────────────────────────────────
          Text(
            'Analyze Emotion',
            style: AppTextTheme.font20BoldPrimary,
          ),
          SizedBox(height: 8.h),
          Text(
            'Upload a video to detect facial emotions in real time.',
            style: AppTextTheme.font13BlackRegular,
          ),
          SizedBox(height: 16.h),

          VideoUploadSection(
            onVideoSelected: (file) {
              setState(() => _selectedVideo = file);
            },
          ),

          SizedBox(height: 24.h),

          // ── Analyze Button ─────────────────────────────────────────────────
          AnalyzeButton(
            onTap: _selectedVideo != null ? _handleAnalyze : () {},
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeSuccess state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Avatar
        _buildAvatar(state),

        // Logout button
        BlocBuilder<LogoutCubit, LogoutState>(
          builder: (context, logoutState) {
            final isLoading = logoutState is LogoutLoading;
            return GestureDetector(
              onTap: isLoading
                  ? null
                  : () => _showLogoutDialog(context),
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
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.error,
                  ),
                )
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout_rounded,
                        size: 16.sp, color: AppColors.error),
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
        ),
      ],
    );
  }

  Widget _buildAvatar(HomeSuccess state) {
    return Row(
      children: [
        // Profile picture or initials
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
              style: AppTextTheme.font14BlackSemiBold,
            ),
            if (state.email.isNotEmpty && !state.isBiometric)
              Text(
                state.email,
                style: AppTextTheme.font12GreyMedium,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(HomeSuccess state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            state.isBiometric
                ? 'Biometric User'
                : state.userName.isNotEmpty
                ? state.userName
                : state.email,
            style: TextStyle(
              fontSize: 22.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  state.isBiometric
                      ? Icons.fingerprint
                      : _loginMethodIcon(state),
                  size: 14.sp,
                  color: AppColors.white,
                ),
                SizedBox(width: 6.w),
                Text(
                  state.isBiometric
                      ? 'Biometric Login'
                      : state.photoUrl.isNotEmpty
                      ? 'Google Account'
                      : 'Email Login',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _loginMethodIcon(HomeSuccess state) {
    if (state.photoUrl.isNotEmpty) return Icons.g_mobiledata_rounded;
    return Icons.email_outlined;
  }

  void _handleAnalyze() {
    // TODO: connect to emotion analysis feature
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analyzing video...')),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<LogoutCubit>().logout();
            },
            child: Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}