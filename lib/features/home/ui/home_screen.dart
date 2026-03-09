import 'dart:io';

import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/home_header.dart';
import 'widgets/welcome_message.dart';
import 'widgets/video_upload_section.dart';
import 'widgets/analyze_button.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  final String? userName;
  final String? photoUrl;
  const HomeScreen({super.key, this.email, this.userName, this.photoUrl});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userEmail;
  String? _userName;
  String? _photoUrl;
  bool _isLoadingEmail = true;
  File? _selectedVideo;
  bool _isBiometricLogin = false;
  bool _isGoogleLogin = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      // Check login method flags
      final isBiometric = await SharedPrefHelper.getBool(CacheConstants.isBiometricLogin);
      final isGoogle = await SharedPrefHelper.getBool(CacheConstants.signInWithGoogle);
      
      setState(() {
        _isBiometricLogin = isBiometric;
        _isGoogleLogin = isGoogle;
      });

      // First check if email was passed as argument (might contain Map with email, userName, photoUrl)
      if (widget.email != null && widget.email!.isNotEmpty) {
        setState(() {
          _userEmail = widget.email;
          _userName = widget.userName;
          _photoUrl = widget.photoUrl;
          _isLoadingEmail = false;
        });
        return;
      }

      // Get email based on login method
      String? email;
      String? name;
      String? photoUrl;

      if (_isBiometricLogin) {
        // For biometric login, get stored email and name
        email = await SharedPrefHelper.getString(CacheConstants.userEmailFromBiometric);
        name = await SharedPrefHelper.getString(CacheConstants.userNameFromBiometric);
      } else if (_isGoogleLogin) {
        // For Google login, get stored email, name and photo URL
        email = await SharedPrefHelper.getString(CacheConstants.userEmailFromGoogle);
        name = await SharedPrefHelper.getString(CacheConstants.userNameFromGoogle);
        photoUrl = await SharedPrefHelper.getString(CacheConstants.userPhotoUrlFromGoogle);
      } else {
        // For email/password login
        email = await SharedPrefHelper.getString(CacheConstants.userEmail);
        name = await SharedPrefHelper.getString(CacheConstants.userName);
        photoUrl = await SharedPrefHelper.getString(CacheConstants.userPhotoUrl);
      }

      setState(() {
        _userEmail = email?.isNotEmpty == true ? email : null;
        _userName = name?.isNotEmpty == true ? name : null;
        _photoUrl = photoUrl?.isNotEmpty == true ? photoUrl : null;
        _isLoadingEmail = false;
      });
      
      Logger.debug('User info loaded - Email: $_userEmail, Name: $_userName, PhotoURL: $_photoUrl, Biometric: $_isBiometricLogin, Google: $_isGoogleLogin');
    } catch (e) {
      setState(() {
        _userEmail = null;
        _userName = null;
        _photoUrl = null;
        _isLoadingEmail = false;
      });
      Logger.debug('Error loading user info: $e');
    }
  }

  void _onVideoSelected(File? video) {
    setState(() {
      _selectedVideo = video;
    });
    if (video != null) {
      Logger.debug('Video selected: ${video.path}');
    }
  }

  void _showAnalysisDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.analytics_rounded,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Analysis Ready',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Your video "${_selectedVideo?.path.split('/').last}" is ready for analysis. This will detect emotions in the video.',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement video analysis
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Starting video analysis...'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Analyze',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider is already provided by app_router.dart
    return Scaffold(
      body: SafeArea(
        child: _isLoadingEmail
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    HomeHeader(photoUrl: _photoUrl),
                    32.verticalSpace,
                    
                    // Welcome Message
                    WelcomeMessage(
                      userEmail: _userEmail,
                      userName: _userName,
                      isBiometricLogin: _isBiometricLogin,
                      isGoogleLogin: _isGoogleLogin,
                    ),
                    32.verticalSpace,
                    
                    // Video Upload Section
                    VideoUploadSection(onVideoSelected: _onVideoSelected),
                    24.verticalSpace,
                    
                    // Action Button (when video is selected)
                    if (_selectedVideo != null) 
                      AnalyzeButton(onTap: _showAnalysisDialog),
                  ],
                ),
              ),
      ),
    );
  }
}
