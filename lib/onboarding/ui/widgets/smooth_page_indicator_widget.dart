import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorWidget extends StatelessWidget {
  const SmoothPageIndicatorWidget({
    super.key,
    required PageController pageController,
    required int currentPage,
  }) : _pageController = pageController, _currentPage = currentPage;

  final PageController _pageController;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: 3,
      effect: WormEffect(
        activeDotColor: _currentPage == 0
            ? Theme.of(context).colorScheme.primary
            : _currentPage == 1
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.tertiary,
        dotColor: _currentPage == 0
            ? Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3)
            : _currentPage == 1
            ? Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.3)
            : Theme.of(
                context,
              ).colorScheme.tertiary.withValues(alpha: 0.3),
      ),
    );
  }
}

