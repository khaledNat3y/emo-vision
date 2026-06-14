import 'package:facial_emotional_detection_graduation_project/features/home/logic/home_cubit/home_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_analyze_section.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_header.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  final HomeSuccess state;
  final ScrollController scrollController;
  final VoidCallback onLogoutTap;

  const HomeScreen({
    super.key,
    required this.state,
    required this.scrollController,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          HomeHeader(state: state, onLogoutTap: onLogoutTap),
          SizedBox(height: 32.h),
          HomeWelcomeCard(state: state),
          SizedBox(height: 32.h),
          const HomeAnalyzeSection(),
        ],
      ),
    );
  }
}
