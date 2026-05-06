//Body
// Separate StatelessWidget so HomeScreen stays clean.
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/home_state.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_analyze_section.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_header.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/home_welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  final HomeSuccess state;
  final ScrollController scrollController;
  final GlobalKey resultKey;
  final VoidCallback onLogoutTap;

  const HomeBody({
    super.key,
    required this.state,
    required this.scrollController,
    required this.resultKey,
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
          HomeAnalyzeSection(resultKey: resultKey),
        ],
      ),
    );
  }
}
