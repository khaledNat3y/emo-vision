import 'dart:ui';

import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/delete_account_cubit/delete_account_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/history_cubit/cubit/history_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/home_cubit/home_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/home_cubit/home_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/upload_video_cubit/upload_video_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/history_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/settings_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/home_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeRoot extends StatefulWidget {
  final String? email;
  final String? userName;
  final String? photoUrl;
  final String? loginMethod;

  const HomeRoot({
    super.key,
    this.email,
    this.userName,
    this.photoUrl,
    this.loginMethod,
  });

  @override
  State<HomeRoot> createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  final ScrollController _scrollController = ScrollController();
  late List<Widget> screens;
  int _currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToResult() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  void _showLogoutDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ctx.read<LogoutCubit>().logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    screens = [
      BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (homeState is HomeFailure) {
            return Center(child: Text(homeState.error));
          }
          if (homeState is HomeSuccess) {
            return HomeScreen(
              state: homeState,
              scrollController: _scrollController,
              onLogoutTap: () => _showLogoutDialog(context),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      const HistoryScreen(),

      const SettingsScreen(),
    ];
  }

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
        BlocProvider(create: (_) => getIt<LogoutCubit>()),
        BlocProvider(create: (_) => getIt<UploadVideoCubit>()),
        BlocProvider(create: (_) => getIt<DeleteAccountCubit>()),
        BlocProvider(create: (_) => getIt<HistoryCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                  predicate: (route) => false,
                );
              }
            },
          ),
          BlocListener<UploadVideoCubit, UploadVideoState>(
            listener: (context, state) {
              if (state is UploadVideoSuccess) {
                _scrollToResult();
                context.read<HistoryCubit>().fetchHistory();
              }
              if (state is UploadVideoError) {
                _scrollToResult();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error.detail?.first.msg ?? 'Upload failed',
                    ),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
          ),
          BlocListener<DeleteAccountCubit, DeleteAccountState>(
            listener: (context, state) {
              if (state is DeleteAccountSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account deleted successfully"),
                    backgroundColor: AppColors.success,
                  ),
                );
                context.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                  predicate: (route) => false,
                );
              }
              if (state is DeleteAccountError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    duration: const Duration(seconds: 5),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
              if (state is DeleteAccountLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Deleting account..."),
                    duration: Duration(seconds: 8),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButton: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 70.h,
                width: MediaQuery.sizeOf(context).width * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.15), // glass base
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavItem(
                      title: "Home",
                      icon: Icons.home_rounded,
                      isActive: _currentIndex == 0,
                      onTap: () {
                        setState(() => _currentIndex = 0);
                      },
                    ),
                    NavItem(
                      title: "History",
                      icon: Icons.history_rounded,
                      isActive: _currentIndex == 1,
                      onTap: () => setState(() => _currentIndex = 1),
                    ),
                    NavItem(
                      title: "Settings",
                      icon: Icons.settings,
                      isActive: _currentIndex == 2,
                      onTap: () {
                        setState(() => _currentIndex = 2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: IndexedStack(index: _currentIndex, children: screens),
          ),
        ),
      ),
    );
  }
}
