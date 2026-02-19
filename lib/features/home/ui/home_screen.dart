import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import '../../../core/theming/app_colors.dart';
import 'widgets/home_header.dart';
import 'widgets/feature_card.dart';
import 'widgets/signout_button.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  const HomeScreen({super.key, this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userEmail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    try {
      // First priority: email passed from previous screen
      if (widget.email != null && widget.email!.isNotEmpty) {
        setState(() {
          _userEmail = widget.email;
          _isLoading = false;
        });
        return;
      }

      final String normalEmail = await SharedPrefHelper.getString(CacheConstants.userEmail);
      final String googleEmail = await SharedPrefHelper.getString(CacheConstants.userEmailFromGoogle);

      setState(() {
        if (normalEmail.isNotEmpty) {
          _userEmail = normalEmail;
        } else if (googleEmail.isNotEmpty) {
          _userEmail = googleEmail;
        } else {
          _userEmail = null; // No email found
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _userEmail = null;
        _isLoading = false;
      });
      debugPrint('Error loading email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while fetching email
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    // Determine email to display
    final String userEmail = _userEmail ?? "No email provided";
    final String userName = _userEmail != null
        ? _userEmail!.split('@')[0]
        : "User";

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            HomeHeader(
              userName: userName,
              email: userEmail,
            ),

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Main Feature Cards
                    FeatureCard(
                      icon: Icons.camera_alt_outlined,
                      title: 'Start Detection',
                      subtitle: 'Detect emotions in real-time',
                      color: AppColors.primary,
                      onTap: () {
                        // Navigate to camera/detection screen
                      },
                    ),
                    const SizedBox(height: 16),

                    FeatureCard(
                      icon: Icons.image_outlined,
                      title: 'Upload Image',
                      subtitle: 'Analyze emotions from photos',
                      color: AppColors.secondary,
                      onTap: () {
                        // Navigate to image upload screen
                      },
                    ),
                    const SizedBox(height: 16),

                    FeatureCard(
                      icon: Icons.history_outlined,
                      title: 'History',
                      subtitle: 'View past detections',
                      color: AppColors.tertiary,
                      onTap: () {
                        // Navigate to history screen
                      },
                    ),

                    const Spacer(),

                    // Sign Out Button
                    const SignOutButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}