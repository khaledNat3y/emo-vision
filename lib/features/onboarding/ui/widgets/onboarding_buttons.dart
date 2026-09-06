import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:flutter/material.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({
    super.key,
    required int currentPage,
    required PageController pageController,
  }) : _currentPage = currentPage, _pageController = pageController;

  final int _currentPage;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage == 0
                  ? Theme.of(context).colorScheme.primary
                  : _currentPage == 1
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              if (_currentPage == 2) {
                // Mark onboarding as seen
                await SharedPrefHelper.setData(CacheConstants.hasSeenOnboarding, true);
                if (context.mounted) {
                  context.pushReplacementNamed(Routes.loginScreen);
                }
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(
              _currentPage == 2 ? 'Get Started' : 'Next',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_currentPage < 2)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                await SharedPrefHelper.setData(CacheConstants.hasSeenOnboarding, true);
                if (context.mounted) {
                  context.pushReplacementNamed(Routes.loginScreen);
                }
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
