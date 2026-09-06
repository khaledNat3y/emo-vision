import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/home_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/home_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/upload_video_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  final String? userName;
  final String? photoUrl;
  final String? loginMethod;

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
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _resultKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Waits for the result widget to be inserted and laid out,
  /// then smoothly scrolls to the bottom.
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
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, homeState) {
                if (homeState is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (homeState is HomeFailure) {
                  return Center(child: Text(homeState.error));
                }
                if (homeState is HomeSuccess) {
                  return HomeBody(
                    state: homeState,
                    scrollController: _scrollController,
                    resultKey: _resultKey,
                    onLogoutTap: () => _showLogoutDialog(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
