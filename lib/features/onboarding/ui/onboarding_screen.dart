import 'package:facial_emotional_detection_graduation_project/features/onboarding/ui/widgets/onboarding_buttons.dart';
import 'package:facial_emotional_detection_graduation_project/features/onboarding/ui/widgets/onboarding_page.dart';
import 'package:facial_emotional_detection_graduation_project/features/onboarding/ui/widgets/smooth_page_indicator_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: const [
              OnboardingPage(
                icon: Icons.security,
                title: 'Secure & Safe',
                description:
                    'Your data is encrypted and protected with industry-leading security standards.',
                color: Color(0xFF3B82F6),
              ),
              OnboardingPage(
                icon: Icons.light_mode_outlined,
                title: 'Lightning Fast',
                description:
                    'Access your account instantly with our optimized authentication system.',
                color: Color(0xFF06B6D4),
              ),
              OnboardingPage(
                icon: Icons.people,
                title: 'Easy to Use',
                description:
                    'Simple and intuitive login process designed for everyone.',
                color: Color(0xFF8B5CF6),
              ),
            ],
          ),
          // Indicator
          Positioned(
            bottom: 200,
            left: MediaQuery.of(context).size.width / 2 - 30,
            right: 0,
            child: SmoothPageIndicatorWidget(pageController: _pageController, currentPage: _currentPage),
          ),
          // Buttons
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: OnboardingButtons(currentPage: _currentPage, pageController: _pageController),
          ),
        ],
      ),
    );
  }
}