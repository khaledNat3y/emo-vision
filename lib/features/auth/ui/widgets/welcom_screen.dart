import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import '../../../../core/theming/app_colors.dart';


class EnhancedWelcomeScreen extends StatefulWidget {
  const EnhancedWelcomeScreen({super.key});

  @override
  State<EnhancedWelcomeScreen> createState() => _EnhancedWelcomeScreenState();
}

class _EnhancedWelcomeScreenState extends State<EnhancedWelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _welcomeController;
  late AnimationController _appNameController;
  late AnimationController _taglineController;
  late AnimationController _loaderController;
  late AnimationController _scaleController;

  late Animation<Offset> _iconSlideAnimation;
  late Animation<double> _iconFadeAnimation;

  late Animation<Offset> _welcomeSlideAnimation;
  late Animation<double> _welcomeFadeAnimation;

  late Animation<Offset> _appNameSlideAnimation;
  late Animation<double> _appNameFadeAnimation;

  late Animation<Offset> _taglineSlideAnimation;
  late Animation<double> _taglineFadeAnimation;

  late Animation<Offset> _loaderSlideAnimation;
  late Animation<double> _loaderFadeAnimation;

  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize all animation controllers
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _welcomeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _appNameController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _taglineController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _loaderController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Scale animation controller for pulsing effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Icon animations
    _iconSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeOutBack,
    ));

    _iconFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeIn,
    ));

    // Welcome text animations
    _welcomeSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _welcomeController,
      curve: Curves.easeOutBack,
    ));

    _welcomeFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _welcomeController,
      curve: Curves.easeIn,
    ));

    // App name animations
    _appNameSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _appNameController,
      curve: Curves.easeOutBack,
    ));

    _appNameFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _appNameController,
      curve: Curves.easeIn,
    ));

    // Tagline animations
    _taglineSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _taglineController,
      curve: Curves.easeOutBack,
    ));

    _taglineFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _taglineController,
      curve: Curves.easeIn,
    ));

    // Loader animations
    _loaderSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _loaderController,
      curve: Curves.easeOutBack,
    ));

    _loaderFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loaderController,
      curve: Curves.easeIn,
    ));

    // Scale animation for the app name
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    // Start animations sequentially
    _startSequentialAnimations();
  }

  void _startSequentialAnimations() async {
    // Start with a small initial delay
    await Future.delayed(const Duration(milliseconds: 300));

    // 1. Animate icon
    _iconController.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    // 2. Animate "Welcome to" text
    _welcomeController.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    // 3. Animate app name
    _appNameController.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    // 4. Animate tagline
    _taglineController.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    // 5. Animate loader
    _loaderController.forward();

    // Start pulsing animation for app name
    _scaleController.repeat(reverse: true);

    // Wait 2 seconds after all animations complete, then navigate
    await Future.delayed(const Duration(milliseconds: 2600));

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void dispose() {
    _iconController.dispose();
    _welcomeController.dispose();
    _appNameController.dispose();
    _taglineController.dispose();
    _loaderController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundDark,
              AppColors.surfaceDark,
              AppColors.primary.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background circles
            Positioned(
              top: -100,
              right: -100,
              child: _buildAnimatedCircle(300, AppColors.primary.withValues(alpha: 0.05)),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: _buildAnimatedCircle(400, AppColors.secondary.withOpacity(0.03)),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated icon or logo placeholder
                  SlideTransition(
                    position: _iconSlideAnimation,
                    child: FadeTransition(
                      opacity: _iconFadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.secondary,
                                AppColors.primary,
                                AppColors.tertiary,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.visibility,
                            size: 50,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // "Welcome to" text
                  SlideTransition(
                    position: _welcomeSlideAnimation,
                    child: FadeTransition(
                      opacity: _welcomeFadeAnimation,
                      child: const Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 28,
                          color: AppColors.textSecondaryDark,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // App name with scale animation
                  SlideTransition(
                    position: _appNameSlideAnimation,
                    child: FadeTransition(
                      opacity: _appNameFadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              AppColors.white,
                              AppColors.secondary,
                              AppColors.primary,
                            ],
                          ).createShader(bounds),
                          child: const Text(
                            'EmoVision',
                            style: TextStyle(
                              fontSize: 64,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tagline
                  SlideTransition(
                    position: _taglineSlideAnimation,
                    child: FadeTransition(
                      opacity: _taglineFadeAnimation,
                      child: const Text(
                        'Your Emotion Recognition App',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textTertiaryDark,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Elegant loading indicator
                  SlideTransition(
                    position: _loaderSlideAnimation,
                    child: FadeTransition(
                      opacity: _loaderFadeAnimation,
                      child: const SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.secondary,
                          ),
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCircle(double size, Color color) {
    return AnimatedBuilder(
      animation: _iconController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_iconController.value * 0.2),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      },
    );
  }
}