# Core Layer Quick Reference Guide

This document provides a comprehensive reference for the presentation layer of the Emovision Flutter project.

## File Structure Overview

```
lib/
├── core/
│   ├── constant/
│   │   ├── cache_constants.dart      # SharedPreferences keys
│   │   └── firebase_constants.dart   # Firebase configuration
│   ├── helpers/
│   │   ├── app_assets.dart           # Asset paths (auto-generated)
│   │   ├── app_regex.dart            # Validation regex patterns
│   │   ├── app_startup.dart          # App initialization
│   │   ├── constants.dart            # Shared preferences keys
│   │   ├── extensions.dart           # Context, String, List extensions
│   │   ├── functions.dart            # Utility functions
│   │   ├── logger.dart               # Debug logging
│   │   └── spacing.dart              # Spacing helpers with .h/.w
│   ├── networking/
│   │   ├── api_constant.dart         # API endpoints
│   │   ├── api_error_handler.dart    # Error handling
│   │   └── dio_helper.dart           # HTTP client
│   ├── routing/
│   │   ├── app_router.dart           # Route generation
│   │   └── routes.dart               # Route name constants
│   ├── services/
│   │   ├── auth_service.dart         # Authentication service
│   │   ├── biometric_service.dart    # Biometric auth
│   │   ├── firebase_services.dart    # Firebase services
│   │   ├── supabase/                 # Supabase integration
│   │   └── upload_video_service.dart # Video processing API
│   ├── theming/
│   │   ├── app_colors.dart           # Color palette
│   │   ├── app_text_theme.dart       # Pre-defined text styles
│   │   ├── app_theme.dart            # Light/Dark theme configuration
│   │   ├── font_weight_helper.dart   # Font weight constants
│   │   └── cubit/
│   │       └── theme_cubit.dart      # Theme state management
│   └── widgets/
│       ├── app_text_form_field.dart  # Styled text input
│       ├── custom_btn.dart           # Gradient button
│       ├── password_validation.dart  # Password requirements UI
│       └── video_upload_widget.dart  # Video picker widget
├── features/
│   ├── auth/
│   │   └── ui/widgets/               # Login, register, OTP, social auth
│   ├── home/
│   │   └── ui/widgets/               # Video upload, results, header
│   └── onboarding/
│       └── ui/widgets/               # Onboarding pages, indicators
└── main files...
```

---

## Design System

### AppColors (`lib/core/theming/app_colors.dart`)

```dart
// Light Theme
AppColors.backgroundLight     // White background
AppColors.surfaceLight        // Surface color
AppColors.textPrimaryLight    // Primary text (#0F172A)
AppColors.textTertiaryLight   // Tertiary text (#94A3B8)
AppColors.borderLight         // Border color
AppColors.dividerLight        // Divider color

// Dark Theme
AppColors.backgroundDark      // Dark background (#0F172A)
AppColors.surfaceDark         // Dark surface (#1e293b)
AppColors.textPrimaryDark     // White text
AppColors.textSecondaryDark   // Secondary text (#CBD5E1)
AppColors.borderDark          // Dark borders

// Status Colors
AppColors.primary             // Main brand blue (#1D61E7)
AppColors.primaryDark         // Darker blue (#1d4ed8)
AppColors.secondary           // Cyan (#06B6D4)
AppColors.tertiary            // Purple (#8B5CF6)
AppColors.success             // Green (#10b981)
AppColors.error               // Red (#ef4444)
AppColors.warning             // Amber (#f59e0b)
AppColors.grey                // Neutral grey (#6C7278)
```

**Usage Example:**
```dart
Container(
  color: AppColors.primary,
  child: Text('Hello', style: TextStyle(color: AppColors.white)),
)
```

### AppTextTheme (`lib/core/theming/app_text_theme.dart`)

```dart
// Light Theme Styles
AppTextTheme.font24BlackBold          // 24sp, bold, primary text
AppTextTheme.font14BlackSemiBold      // 14sp, semiBold, black
AppTextTheme.font12GreyMedium         // 12sp, medium, grey
AppTextTheme.font12BlueRegular        // 12sp, regular, primary color
AppTextTheme.font13BlackRegular       // 13sp, regular, primary text
AppTextTheme.font16WhiteMedium        // 16sp, medium, white

// Dark Theme Styles
AppTextTheme.font24WhiteBold          // 24sp, bold, white
AppTextTheme.font13WhiteRegular       // 13sp, regular, white
AppTextTheme.font16PrimaryMedium      // 16sp, medium, primary
AppTextTheme.font20BoldPrimary        // 20sp, bold, primary
```

**Usage Example:**
```dart
Text(
  'Welcome',
  style: AppTextTheme.font24BlackBold,
)
```

### FontWeightHelper (`lib/core/theming/font_weight_helper.dart`)

```dart
FontWeightHelper.thin         // w100
FontWeightHelper.extraLight   // w200
FontWeightHelper.light        // w300
FontWeightHelper.regular      // w400
FontWeightHelper.medium       // w500
FontWeightHelper.semiBold     // w600
FontWeightHelper.bold         // w700
FontWeightHelper.extraBold    // w800
```

### Spacing Helpers (`lib/core/helpers/spacing.dart`)

```dart
// Using extension methods with ScreenUtil
10.verticalSpace     // SizedBox(height: 10.h)
10.horizontalSpace   // SizedBox(width: 10.w)

// Import needed:
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

**Usage Example:**
```dart
Column(
  children: [
    Text('First'),
    16.verticalSpace,
    Text('Second'),
  ],
)
```

### AppTheme (`lib/core/theming/app_theme.dart`)

```dart
// Light/Dark theme data with full configuration
ThemeData lightMode = AppTheme.lightMode;
ThemeData darkMode = AppTheme.darkMode;

// Theme includes:
// - Color scheme (primary, secondary, error, etc.)
// - Scaffold background color
// - ElevatedButton, TextButton, OutlinedButton themes
// - TextTheme with all text styles
```

---

## Core Widgets

### AppTextFormField (`lib/core/widgets/app_text_form_field.dart`)

Customizable text input field with built-in styling.

```dart
AppTextFormField(
  controller: emailController,
  hintText: "Enter email",
  isObscureText: false,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  },
  suffixIcon: IconButton(...),
)
```

**Key Properties:**
- `controller` - TextEditingController
- `hintText` - Placeholder text
- `isObscureText` - Password field
- `validator` - Required validation function
- `suffixIcon` / `prefixIcon` - Optional icons
- `backgroundColor` - Field background color

### CustomBtn (`lib/core/widgets/custom_btn.dart`)

Gradient button with loading state.

```dart
CustomBtn(
  title: 'Sign In',
  onTap: () => signIn(),
  isLoading: isLoading,  // Optional
)
```

**Usage Example:**
```dart
CustomBtn(
  title: 'Continue',
  isLoading: state is LoginLoading,
  onTap: () => context.read<LoginCubit>().login(...),
)
```

### PasswordValidation (`lib/core/widgets/password_validation.dart`)

Visual password requirements checker.

```dart
PasswordValidation(
  hasLowerCase: AppRegex.hasLowerCase(password),
  hasUpperCase: AppRegex.hasUpperCase(password),
  hasSpecialCharacters: AppRegex.hasSpecialCharacter(password),
  hasNumber: AppRegex.hasNumber(password),
  hasMinLength: AppRegex.hasMinLength(password),
)
```

### VideoUploadWidget (`lib/core/widgets/video_upload_widget.dart`)

Video picker widget with preview.

```dart
VideoUploadWidget(
  onVideoSelected: (File? video) {
    setState(() => _video = video);
  },
)
```

---

## Extensions

### Navigation Extension (`lib/core/helpers/extensions.dart`)

```dart
// Context navigation
context.pushNamed('/route')
context.pushReplacementNamed('/route')
context.pushNamedAndRemoveUntil('/route', predicate: (r) => false)
context.pop()
```

### String/List Extensions

```dart
String? email;
email.isNullOrEmpty()  // Returns true if null or empty

List? items;
items.isNullOrEmpty()  // Returns true if null or empty
```

### Form Auto-Scroll

```dart
final formKey = GlobalKey<FormState>();

// Scrolls to first error on validation failure
formKey.validateAndScroll();
```

---

## Constants & Enums

### Routes (`lib/core/routing/routes.dart`)

```dart
Routes.onBoardingScreen          // '/onBoardingScreen'
Routes.loginScreen             // '/loginScreen'
Routes.registerScreen          // '/registerScreen'
Routes.homeScreen              // '/homeScreen'
Routes.biometricLoginScreen    // '/biometricLoginScreen'
Routes.forgotPasswordScreen    // '/forgotPasswordScreen'
Routes.resetPasswordScreen     // '/resetPasswordScreen'
```

### CacheConstants (`lib/core/constant/cache_constants.dart`)

```dart
// SharedPreferences keys
CacheConstants.supabaseAccessToken  // 'supabase_access_token'
CacheConstants.userEmail            // 'userEmail'
CacheConstants.userName             // 'userName'
CacheConstants.userPhotoUrl         // 'userPhotoUrl'
CacheConstants.hasSeenOnboarding    // 'has_seen_onboarding'
CacheConstants.isBiometricLogin     // 'isBiometric'
```

### AppAssets (`lib/core/helpers/app_assets.dart`)

```dart
AppAssets.appLogo               // 'assets/images/login_screen/app_logo.png'
AppAssets.loginScreenHead       // 'assets/images/login_screen/head.png'
AppAssets.lottieLoadingAnimation // 'assets/lottie/loading_animation.json'
AppAssets.googleIcon            // "assets/svgs/google_icon.svg"
AppAssets.facebookIcon          // "assets/svgs/facebook_icon.svg"
AppAssets.biometric             // "assets/svgs/biometric.svg"
```

### AppRegex (`lib/core/helpers/app_regex.dart`)

```dart
// Validation methods
AppRegex.isEmailValid(email)           // Email validation
AppRegex.isPasswordValid(password)       // Full password validation
AppRegex.isPhoneNumberValid(phone)       // Phone number (Egyptian format)

// Password component checks
AppRegex.hasLowerCase(password)          // At least 1 lowercase
AppRegex.hasUpperCase(password)          // At least 1 uppercase
AppRegex.hasNumber(password)             // At least 1 number
AppRegex.hasSpecialCharacter(password)   // At least 1 special char
AppRegex.hasMinLength(password)          // At least 8 characters
```

**Usage Example:**
```dart
TextFormField(
  validator: (value) {
    if (!AppRegex.isEmailValid(value!)) {
      return 'Invalid email';
    }
    return null;
  },
)
```

### ApiConstants (`lib/core/networking/api_constant.dart`)

```dart
ApiConstants.baseUrl                  // Backend API
ApiConstants.videoProcessingBaseUrl   // ML API endpoint

// Endpoints
ApiConstants.login
ApiConstants.register
ApiConstants.verifyEmail
ApiConstants.logout
ApiConstants.me
ApiConstants.refreshToken
ApiConstants.forgotPassword
ApiConstants.resetPassword
ApiConstants.resendOtp
ApiConstants.uploadVideo              // '/predict'
```

---

## Utilities

### Logger (`lib/core/helpers/logger.dart`)

```dart
Logger.debug('Debug message')
Logger.info('Info message')
Logger.warning('Warning message')
Logger.error('Error message')
```

### Shared Preferences Helper (`lib/core/helpers/shared_pref_helper.dart`)

```dart
// Get data
final email = await SharedPrefHelper.getSecuredString('key');
final hasSeen = await SharedPrefHelper.getBool('has_seen');

// Set data
await SharedPrefHelper.setSecuredString('key', value);
await SharedPrefHelper.setBool('has_seen', true);
```

---

## Quick Reference: Replacing Hardcoded Values

| Hardcoded | Replace With |
|-----------|--------------|
| `Color(0xff1D61E7)` | `AppColors.primary` |
| `Color(0xffffffff)` | `AppColors.white` |
| `Color(0xff0F172A)` | `AppColors.textPrimaryLight` |
| `Colors.grey` | `AppColors.grey` |
| `Colors.red` | `AppColors.error` |
| `Colors.green` | `AppColors.success` |
| `TextStyle(fontSize: 24, fontWeight: FontWeight.bold)` | `AppTextTheme.font24BlackBold` |
| `SizedBox(height: 16)` | `16.verticalSpace` |
| `BorderRadius.circular(16)` | `BorderRadius.circular(16.r)` |
| `'Enter email'` | Use localized strings |
| `Navigator.pushNamed(context, '/login')` | `context.pushNamed(Routes.loginScreen)` |

---

## Features Layer Overview

### Auth Feature (`lib/features/auth/`)

| Widget | File Path | Purpose |
|--------|-----------|---------|
| LoginForm | `ui/widgets/login_form.dart` | Email/password login form |
| CustomButton | `ui/widgets/custom_button.dart` | Reusable button with loading state |
| CustomLoginMethod | `ui/widgets/custom_login_method.dart` | Social auth buttons (Google, Facebook) |
| LoginBlocListener | `ui/widgets/login_bloc_listener.dart` | BLoC state handling |
| RegisterForm | `ui/widgets/register_form.dart` | Registration form |
| OtpPinField | `ui/widgets/otp_pin_field.dart` | OTP input field |
| PhoneTextField | `ui/widgets/phone_text_field.dart` | Phone number input |
| LoginRegisterScreenHeaderColumn | `ui/widgets/login_register_screen_header_column.dart` | Header with logo |

### Home Feature (`lib/features/home/`)

| Widget | File Path | Purpose |
|--------|-----------|---------|
| HomeBody | `ui/widgets/home_body.dart` | Main home screen layout |
| HomeHeader | `ui/widgets/home_header.dart` | User avatar, logout button |
| HomeWelcomeCard | `ui/widgets/home_welcome_card.dart` | Welcome banner with login type |
| HomeAnalyzeSection | `ui/widgets/home_analyze_section.dart` | Video upload & analysis |
| VideoUploadSection | `ui/widgets/video_upload_section.dart` | Video picker UI |
| AnalyzeButton | `ui/widgets/analyze_button.dart` | Gradient analysis button |
| HomeResultCard | `ui/widgets/home_result_card.dart` | Emotion analysis results |

### Onboarding Feature (`lib/features/onboarding/`)

| Widget | File Path | Purpose |
|--------|-----------|---------|
| OnboardingPage | `ui/widgets/onboarding_page.dart` | Single onboarding page |
| OnboardingButtons | `ui/widgets/onboarding_buttons.dart` | Skip/Next/Done buttons |
| SmoothPageIndicatorWidget | `ui/widgets/smooth_page_indicator_widget.dart` | Dots indicator |

---

## Common Patterns

### Button with Loading State
```dart
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    return CustomButton(
      text: 'Sign In',
      isLoading: state is LoginLoading,
      onPressed: () => context.read<AuthCubit>().login(...),
    );
  },
)
```

### Form with Validation
```dart
Form(
  key: formKey,
  child: Column(
    children: [
      AppTextFormField(
        controller: emailController,
        hintText: 'Email',
        validator: (value) {
          if (!AppRegex.isEmailValid(value!)) {
            return 'Invalid email';
          }
          return null;
        },
      ),
      16.verticalSpace,
      // More fields...
    ],
  ),
)
```

### Navigation
```dart
// Push
context.pushNamed(Routes.homeScreen);

// Push replacement
context.pushReplacementNamed(Routes.loginScreen);

// Push and remove until
context.pushNamedAndRemoveUntil(
  Routes.loginScreen,
  predicate: (route) => false,
);
```

### Theme Usage
```dart
// Access theme colors
Theme.of(context).colorScheme.primary
Theme.of(context).scaffoldBackgroundColor
Theme.of(context).textTheme.bodyMedium

// Access theme mode
context.watch<ThemeCubit>().state
```