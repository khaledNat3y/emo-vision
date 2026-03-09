# Core Reference Guide

This document provides a quick reference for the presentation layer of the Flutter project, covering design system tokens, reusable widgets, UI components, constants, enums, and utilities available in the `lib/core/` directory.

---

## Table of Contents

1. [Design System](#design-system)
   - [Colors](#colors)
   - [Typography](#typography)
   - [Spacing](#spacing)
   - [Font Weights](#font-weights)
2. [Core Widgets](#core-widgets)
3. [UI Components](#ui-components)
4. [Constants & Enums](#constants--enums)
5. [Utilities](#utilities)
6. [Quick Reference](#quick-reference)
7. [File Structure Overview](#file-structure-overview)

---

## Design System

### Colors

**File:** [`lib/core/theming/app_colors.dart`](lib/core/theming/app_colors.dart)

#### Light Theme Colors

| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.backgroundLight` | `0xffffffff` | Scaffold background |
| `AppColors.surfaceLight` | `0xffffffff` | Surface/Card background |
| `AppColors.textPrimaryLight` | `0xff0F172A` | Primary text |
| `AppColors.grey` | `0xff6C7278` | Secondary text |
| `AppColors.textTertiaryLight` | `0xff94A3B8` | Hint/placeholder text |
| `AppColors.borderLight` | `0xffEDF1F3` | Border color |
| `AppColors.dividerLight` | `0xfff0f0f0` | Divider lines |

#### Dark Theme Colors

| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.backgroundDark` | `0xff0F172A` | Scaffold background |
| `AppColors.surfaceDark` | `0xff1e293b` | Surface/Card background |
| `AppColors.textPrimaryDark` | `0xffffffff` | Primary text |
| `AppColors.textSecondaryDark` | `0xffCBD5E1` | Secondary text |
| `AppColors.textTertiaryDark` | `0xff94A3B8` | Hint/placeholder text |
| `AppColors.borderDark` | `0xff334155` | Border color |
| `AppColors.dividerDark` | `0xff475569` | Divider lines |

#### Common Colors

| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.white` | `0xffffffff` | White color |
| `AppColors.black` | `0xff000000` | Black color |
| `AppColors.primary` | `0xff1D61E7` | Primary brand color |
| `AppColors.primaryDark` | `0xff1d4ed8` | Primary hover/dark variant |
| `AppColors.secondary` | `0xff06B6D4` | Secondary brand color |
| `AppColors.tertiary` | `0xff8B5CF6` | Tertiary accent color |
| `AppColors.success` | `0xff10b981` | Success states |
| `AppColors.error` | `0xffef4444` | Error states |
| `AppColors.warning` | `0xfff59e0b` | Warning states |

#### Usage Example

```dart
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';

// Using colors in a Container
Container(
  color: AppColors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.white),
  ),
)

// Using in theme-aware contexts
Container(
  color: Theme.of(context).brightness == Brightness.dark 
      ? AppColors.backgroundDark 
      : AppColors.backgroundLight,
)
```

---

### Typography

**File:** [`lib/core/theming/app_text_theme.dart`](lib/core/theming/app_text_theme.dart)

The project uses **League Spartan** font family with responsive sizing via `flutter_screenutil`.

#### Predefined Text Styles

| Style | Size | Weight | Color | Usage |
|-------|------|--------|-------|-------|
| `font24BlackBold` | 24.sp | Bold | textPrimaryLight | Headlines |
| `font14BlackSemiBold` | 14.sp | SemiBold | black | Subheadings |
| `font12GreyMedium` | 12.sp | Medium | grey | Captions |
| `font12BlueRegular` | 12.sp | Regular | primary | Links |
| `font13BlackRegular` | 13.sp | Regular | textPrimaryLight | Body text |
| `font16WhiteMedium` | 16.sp | Medium | white | Button text |
| `font24WhiteBold` | 24.sp | Bold | textPrimaryDark | Dark theme headlines |
| `font16PrimaryMedium` | 16.sp | Medium | primary | Primary text |
| `font20BoldPrimary` | 20.sp | Bold | textPrimaryLight | Titles |
| `font18MediumSecondary` | 18.sp | Medium | grey | Secondary headings |
| `font14RegularTertiary` | 14.sp | Regular | textTertiaryLight | Tertiary text |

#### Theme-based Text Styles

Access via `Theme.of(context).textTheme`:

```dart
Text(
  'Headline',
  style: Theme.of(context).textTheme.headlineLarge,   // 32.sp, Bold
)

Text(
  'Title',
  style: Theme.of(context).textTheme.titleLarge,      // 16.sp, Bold
)

Text(
  'Body',
  style: Theme.of(context).textTheme.bodyLarge,       // 16.sp, Regular
)

Text(
  'Caption',
  style: Theme.of(context).textTheme.bodySmall,       // 12.sp, Regular
)
```

---

### Spacing

**File:** [`lib/core/helpers/spacing.dart`](lib/core/helpers/spacing.dart)

Use `flutter_screenutil` for responsive spacing:

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Vertical spacing
SizedBox(height: 20.h)

// Horizontal spacing  
SizedBox(width: 16.w)

// Using the helper functions
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';

verticalSpace(20)  // Creates SizedBox(height: 20.h)
horizontalSpace(16)  // Creates SizedBox(width: 16.w)
```

---

### Font Weights

**File:** [`lib/core/theming/font_weight_helper.dart`](lib/core/theming/font_weight_helper.dart)

| Token | Value |
|-------|-------|
| `FontWeightHelper.thin` | w100 |
| `FontWeightHelper.extraLight` | w200 |
| `FontWeightHelper.light` | w300 |
| `FontWeightHelper.regular` | w400 |
| `FontWeightHelper.medium` | w500 |
| `FontWeightHelper.semiBold` | w600 |
| `FontWeightHelper.bold` | w700 |
| `FontWeightHelper.extraBold` | w800 |

---

## Core Widgets

### Custom Button

**File:** [`lib/core/widgets/custom_btn.dart`](lib/core/widgets/custom_btn.dart)

A full-width gradient button with loading state support.

```dart
import 'package:facial_emotional_detection_graduation_project/core/widgets/custom_btn.dart';

CustomBtn(
  title: 'Submit',
  onTap: () {
    // Handle tap
  },
  isLoading: false, // Optional: show loading state
)
```

**Features:**
- Full-width container
- Gradient background (primary to primaryDark)
- Loading state with grey background
- Uses `AppTextTheme.font16WhiteMedium` for text styling

---

### Text Form Field

**File:** [`lib/core/widgets/app_text_form_field.dart`](lib/core/widgets/app_text_form_field.dart)

A customizable text input field with built-in styling.

```dart
import 'package:facial_emotional_detection_graduation_project/core/widgets/app_text_form_field.dart';

AppTextFormField(
  hintText: 'Enter your email',
  controller: _emailController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  },
  // Optional parameters:
  isObscureText: false,
  suffixIcon: Icon(Icons.visibility),
  backgroundColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12.5),
  isReadOnly: false,
)
```

**Features:**
- Customizable border styles (focused, enabled, error)
- Built-in hint text styling
- Support for suffix icons
- Read-only mode support
- Initial value support

---

### Password Validation

**File:** [`lib/core/widgets/password_validation.dart`](lib/core/widgets/password_validation.dart)

A widget that shows password validation requirements with visual feedback.

```dart
import 'package:facial_emotional_detection_graduation_project/core/widgets/password_validation.dart';

PasswordValidation(
  hasLowerCase: true,    // Check if password has lowercase
  hasUpperCase: true,    // Check if password has uppercase  
  hasSpecialCharacters: true,  // Check for special chars
  hasNumber: true,       // Check for numbers
  hasMinLength: true,   // Check minimum 8 characters
)
```

---

## UI Components

### Dialog Functions

**File:** [`lib/core/helpers/functions.dart`](lib/core/helpers/functions.dart)

#### Show Enhanced Dialog

```dart
import 'package:facial_emotional_detection_graduation_project/core/helpers/functions.dart';

// Error Dialog
showEnhancedDialog(
  context: context,
  isError: true,
  data: ApiErrorModel(
    message: 'Something went wrong',
    statusCode: 400,
    errors: ['Invalid input'],
  ),
);

// Success Dialog
showEnhancedDialog(
  context: context,
  isError: false,
  successTitle: 'Success',
  successMessage: 'Operation completed!',
);
```

---

## Constants & Enums

### Cache Constants

**File:** [`lib/core/constant/cache_constants.dart`](lib/core/constant/cache_constants.dart)

```dart
import 'package:facial_emotional_detection_graduation_project/core/constant/cache_constants.dart';

// Access tokens
CacheConstants.accessToken      // 'access_token'
CacheConstants.refreshToken     // 'refresh_token'
CacheConstants.phoneNumber       // 'phone_number'

// User preferences
CacheConstants.hasSeenOnboarding // 'has_seen_onboarding'
CacheConstants.isBiometricLogin  // 'isBiometric'
CacheConstants.userEmail         // 'userEmailFromArgs'
CacheConstants.userEmailFromGoogle // 'userEmailFromGoogle'
CacheConstants.signInWithGoogle  // 'signInWithGoogle'
```

### Shared Preferences Keys

**File:** [`lib/core/helpers/constants.dart`](lib/core/helpers/constants.dart)

```dart
import 'package:facial_emotional_detection_graduation_project/core/helpers/constants.dart';

SharedPrefKeys.userToken  // 'userToken'
```

### Routes

**File:** [`lib/core/routing/routes.dart`](lib/core/routing/routes.dart)

```dart
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';

// Available routes
Routes.onBoardingScreen   // "/onBoardingScreen"
Routes.loginScreen        // "/loginScreen"
Routes.registerScreen    // "/registerScreen"
Routes.otpScreen         // "/otpScreen"
Routes.otpSuccessScreen  // "/otpSuccessScreen"
Routes.homeScreen        // "/homeScreen"
```

---

## Utilities

### Regex Validators

**File:** [`lib/core/helpers/app_regex.dart`](lib/core/helpers/app_regex.dart)

```dart
import 'package:facial_emotional_detection_graduation_project/core/helpers/app_regex.dart';

// Email validation
AppRegex.isEmailValid('test@example.com')  // true

// Password validation (min 8 chars, uppercase, lowercase, number, special char)
AppRegex.isPasswordValid('Password1!')  // true

// Phone number validation (Egyptian numbers)
AppRegex.isPhoneNumberValid('01012345678')  // true

// Password strength checks
AppRegex.hasLowerCase('Password')  // true
AppRegex.hasUpperCase('Password')  // true
AppRegex.hasNumber('Password1')    // true
AppRegex.hasSpecialCharacter('Pass!')  // true
AppRegex.hasMinLength('Password123')  // true
```

---

### Extensions

**File:** [`lib/core/helpers/extensions.dart`](lib/core/helpers/extensions.dart)

#### Navigation Extension

```dart
import 'package:facial_emotional_detection_graduation_project/core/helpers/extensions.dart';

// Push navigation
context.pushNamed('/routeName', arguments: someData);

// Push and replace
context.pushReplacementNamed('/routeName');

// Push and remove until
context.pushNamedAndRemoveUntil(
  '/routeName',
  predicate: (route) => false, // Remove all previous routes
);

// Pop
context.pop();
```

#### String Extension

```dart
String? myString;

myString.isNullOrEmpty()  // Returns true if null or empty
```

#### List Extension

```dart
List<String>? myList;

myList.isNullOrEmpty()  // Returns true if null or empty list
```

#### Form Auto Scroll Extension

```dart
final formKey = GlobalKey<FormState>();

formKey.validateAndScroll()  // Validates and scrolls to first error
```

---

### Shared Preferences Helper

**File:** [`lib/core/helpers/shared_pref_helper.dart`](lib/core/helpers/shared_pref_helper.dart)

```dart
import 'package:facial_emotional_detection_graduation_project/core/helpers/shared_pref_helper.dart';

// Save data
await SharedPrefHelper.setData('key', 'value');
await SharedPrefHelper.setData('count', 42);
await SharedPrefHelper.setData('isEnabled', true);

// Get data
String value = await SharedPrefHelper.getString('key');
int count = await SharedPrefHelper.getInt('count');
bool enabled = await SharedPrefHelper.getBool('isEnabled');

// Secure storage (for sensitive data)
await SharedPrefHelper.setSecuredString('token', 'secret_token');
String token = await SharedPrefHelper.getSecuredString('token');

// Remove data
await SharedPrefHelper.removeData('key');

// Clear all
await SharedPrefHelper.clearAllData();
await SharedPrefHelper.clearAllSecuredData();
```

---

### Assets

**File:** [`lib/core/helpers`](lib/core/helpers/app_assets.dart/app_assets.dart)

```dart
import 'package:facial_emotional_detection_graduation_project/core/helpers/app_assets.dart';

// Image assets
AppAssets.appLogo              // 'assets/images/login_screen/app_logo.png'
AppAssets.loginScreenHead      // 'assets/images/login_screen/head.png'

// Lottie animations
AppAssets.lottieLoadingAnimation  // 'assets/lottie/loading_animation.json'

// SVG icons
AppAssets.googleIcon           // 'assets/svgs/google_icon.svg'
AppAssets.facebookIcon         // 'assets/svgs/facebook_icon.svg'
AppAssets.biometric            // 'assets/svgs/biometric.svg'
```

---

## Quick Reference

### Replacing Hardcoded Values

| Hardcoded | Replace With |
|-----------|--------------|
| `Colors.white` | `AppColors.white` |
| `Colors.black` | `AppColors.black` |
| `Colors.blue` | `AppColors.primary` |
| `FontWeight.bold` | `FontWeightHelper.bold` |
| `16.0` | `16.sp` (with flutter_screenutil) |
| `EdgeInsets.all(16.0)` | `EdgeInsets.all(16.w)` or `16.all` |

### Common Patterns

#### Using the Theme

```dart
// Get colors based on theme
Theme.of(context).colorScheme.primary     // AppColors.primary
Theme.of(context).colorScheme.secondary   // AppColors.secondary

// Get text styles
Theme.of(context).textTheme.headlineMedium
Theme.of(context).textTheme.bodyLarge
```

#### Spacing Quick Reference

```dart
// Always use .h for height and .w for width with screenutil
EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)
Padding(padding: EdgeInsets.all(16.r))  // .r for radius too
```

---

## File Structure Overview

```
lib/core/
├── constant/
│   └── cache_constants.dart          # Cache key constants
├── di/
│   └── dependency_injection.dart    # Dependency injection setup
├── helpers/
│   ├── app_assets.dart               # Asset paths
│   ├── app_regex.dart                # Regex validators
│   ├── constants.dart                # App constants
│   ├── extensions.dart               # Dart extensions
│   ├── functions.dart                # Utility functions
│   ├── logger.dart                   # Logging utilities
│   ├── shared_pref_helper.dart       # SharedPreferences wrapper
│   └── spacing.dart                  # Spacing helpers
├── networking/
│   ├── api_constant.dart
│   ├── api_error_factory.dart
│   ├── api_error_handler.dart
│   ├── api_error_model.dart
│   ├── api_result.dart
│   ├── dio_exception_type_extension.dart
│   ├── dio_factory.dart
│   ├── dio_helper.dart
│   ├── error_model.dart
│   └── local_status_code.dart
├── routing/
│   ├── app_router.dart               # App router configuration
│   ├── router_transitions.dart       # Transition animations
│   └── routes.dart                   # Route constants
├── services/
│   ├── auth_service.dart
│   ├── biometric_service.dart
│   └── firebase_services.dart
├── theming/
│   ├── app_colors.dart               # Color tokens
│   ├── app_text_theme.dart           # Typography styles
│   ├── app_theme.dart                # Theme configuration
│   └── font_weight_helper.dart       # Font weight constants
└── widgets/
    ├── app_text_form_field.dart      # Custom text field
    ├── custom_btn.dart               # Custom button
    └── password_validation.dart      # Password validator widget
```

---

## Additional Notes

1. **Theme Configuration:** The app supports both light and dark modes through `AppTheme.lightMode` and `AppTheme.darkMode` in [`lib/core/theming/app_theme.dart`](lib/core/theming/app_theme.dart)

2. **Responsive Design:** All sizes use `flutter_screenutil` with `.sp`, `.h`, `.w`, and `.r` extensions for responsive design

3. **Font Family:** The app uses "League Spartan" font family

4. **State Management:** The project uses `flutter_bloc` for state management

5. **Navigation:** Uses GoRouter-style routing with custom transitions
