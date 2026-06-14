# Core & Features Presentation Layer Reference

Quick reference guide for the presentation layer components in this Flutter project.

## File Structure Overview

```
lib/
├── core/
│   ├── theming/
│   │   ├── app_colors.dart         # Color tokens
│   │   ├── app_text_theme.dart     # Text styles
│   │   ├── app_theme.dart          # Light/Dark theme definitions
│   │   ├── font_weight_helper.dart  # Font weight constants
│   │   └── cubit/
│   │       └── theme_cubit.dart    # Theme state management
│   ├── widgets/
│   │   ├── app_text_form_field.dart    # Custom text field
│   │   ├── custom_btn.dart             # Gradient button
│   │   ├── video_upload_widget.dart    # Video picker widget
│   │   └── password_validation.dart    # Password rules indicator
│   ├── helpers/
│   │   ├── app_assets.dart           # Asset paths
│   │   ├── app_regex.dart            # Validation regex
│   │   ├── extensions.dart           # Context extensions
│   │   ├── constants.dart            # Shared pref keys
│   │   ├── spacing.dart              # Spacing helpers
│   │   ├── functions.dart            # Dialog utility
│   │   └── logger.dart               # Logging utility
│   ├── routing/
│   │   ├── routes.dart               # Route names
│   │   ├── app_router.dart           # Route generation
│   │   └── router_transitions.dart   # Transition animations
│   ├── constant/
│   │   ├── cache_constants.dart      # Cache keys
│   │   └── firebase_constants.dart   # Firebase config
│   ├── services/
│   │   ├── supabase/                 # Supabase services
│   │   └── firebase_services.dart    # Firebase services
│   └── di/
│       └── dependency_injection.dart   # GetIt setup
└── features/
    ├── home/
    │   └── ui/
    │       ├── home_screen.dart
    │       ├── settings_screen.dart
    │       └── widgets/
    │           ├── home_welcome_card.dart
    │           ├── home_header.dart
    │           ├── home_body.dart
    │           ├── nav_item.dart
    │           ├── home_analyze_section.dart
    │           ├── analyze_button.dart
    │           ├── video_upload_section.dart
    │           ├── home_result_card.dart
    │           └── settings_section.dart
    └── auth/
        └── ui/
            ├── login_screen.dart
            ├── register_screen.dart
            ├── forgot_password_screen.dart
            ├── reset_password_screen.dart
            ├── biometric_login_screen.dart
            └── widgets/
                ├── custom_button.dart
                ├── app_text_form_field.dart (re-exported)
                ├── phone_text_field.dart
                ├── otp_pin_field.dart
                ├── or_login_with_widget.dart
                ├── custom_login_method.dart
                ├── login_logo_and_app_name.dart
                ├── login_register_screen_header_column.dart
                └── dont_have_already_have_account_widget.dart
```

---

## 1. Design System

### Colors - `lib/core/theming/app_colors.dart`

```dart
// Light Theme Colors
AppColors.backgroundLight    // White background (#ffffff)
AppColors.surfaceLight       // Surface color
AppColors.textPrimaryLight   // Primary text (#0F172A)
AppColors.grey               // Grey text (#6C7278)
AppColors.textTertiaryLight  // Tertiary text (#94A3B8)
AppColors.borderLight        // Border color (#EDF1F3)
AppColors.dividerLight       // Divider color (#f0f0f0)

// Dark Theme Colors
AppColors.backgroundDark     // Dark background (#0F172A)
AppColors.surfaceDark        // Dark surface (#1e293b)
AppColors.textPrimaryDark    // Primary text (#ffffff)
AppColors.textSecondaryDark  // Secondary text (#CBD5E1)
AppColors.textTertiaryDark   // Tertiary text (#94A3B8)
AppColors.borderDark         // Border (#334155)
AppColors.dividerDark        // Divider (#475569)

// Common Colors (both themes)
AppColors.white              // White (#ffffff)
AppColors.black              // Black (#000000)
AppColors.primary            // Primary blue (#1D61E7)
AppColors.primaryDark        // Primary dark (avoid using directly)
AppColors.secondary          // Cyan (#06B6D4)
AppColors.tertiary           // Purple (#8B5CF6)
AppColors.success            // Green (#10b981)
AppColors.error              // Red (#ef4444)
AppColors.warning            // Amber (#f59e0b)
```

### Font Weights - `lib/core/theming/font_weight_helper.dart`

```dart
FontWeightHelper.thin        // w100
FontWeightHelper.extraLight  // w200
FontWeightHelper.light       // w300
FontWeightHelper.regular     // w400
FontWeightHelper.medium      // w500
FontWeightHelper.semiBold    // w600
FontWeightHelper.bold        // w700
FontWeightHelper.extraBold   // w800
```

### Text Styles - `lib/core/theming/app_text_theme.dart`

```dart
// Light Theme Styles
AppTextTheme.font24BlackBold    // 24sp, bold, textPrimaryLight

// Universal Styles
AppTextTheme.font14BlackSemiBold  // 14sp, semiBold, black
AppTextTheme.font12GreyMedium     // 12sp, medium, grey
AppTextTheme.font12BlueRegular    // 12sp, regular, primary
AppTextTheme.font13BlackRegular   // 13sp, regular, textPrimaryLight
AppTextTheme.font16WhiteMedium    // 16sp, medium, white (for buttons)
AppTextTheme.font12RegularPrimary // 12sp, regular, primary
AppTextTheme.font13WhiteRegular   // 13sp, regular, textPrimaryDark
AppTextTheme.font16PrimaryMedium  // 16sp, medium, primary
AppTextTheme.font20BoldPrimary    // 20sp, bold, primary
AppTextTheme.font18MediumSecondary // 18sp, medium, grey
AppTextTheme.font14RegularTertiary // 14sp, regular, textTertiaryLight
```

### Theme Data - `lib/core/theming/app_theme.dart`

```dart
// Access current theme
Theme.of(context)              // ThemeData
Theme.of(context).textTheme      // TextTheme
Theme.of(context).colorScheme    // ColorScheme

// Predefined themes
AppTheme.lightMode             // Light ThemeData
AppTheme.darkMode              // Dark ThemeData
```

---

## 2. Core Widgets

### Custom Button - `lib/core/widgets/custom_btn.dart`

```dart
CustomBtn(
  title: 'Sign In',
  onTap: () => login(),
  isLoading: false, // Optional - shows loading state
)

// Full example with loading state
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    return CustomBtn(
      title: 'Login',
      onTap: state is AuthLoading ? null : () => login(),
      isLoading: state is AuthLoading,
    );
  },
)
```

### App Text Form Field - `lib/core/widgets/app_text_form_field.dart`

```dart
AppTextFormField(
  hintText: 'Email',
  controller: emailController,
  validator: (value) => value.isNullOrEmpty() ? 'Required' : null,
  prefixIcon: Icon(Icons.email),
  keyboardType: TextInputType.emailAddress,
)

// With custom styling
AppTextFormField(
  hintText: 'Password',
  isObscureText: true,
  controller: passwordController,
  validator: (value) => AppRegex.isPasswordValid(value) ? null : 'Invalid',
  suffixIcon: Icon(Icons.visibility),
)
```

### Video Upload Widget - `lib/core/widgets/video_upload_widget.dart`

```dart
VideoUploadWidget(
  title: 'Select Video',
  subtitle: 'Choose from gallery',
  onVideoSelected: (File? file) {
    if (file != null) {
      // Handle selected video
    }
  },
)

// Initial video path (for edit mode)
VideoUploadWidget(
  initialVideoPath: existingVideoPath,
  onVideoSelected: handleVideoSelection,
)
```

### Password Validation - `lib/core/widgets/password_validation.dart`

```dart
PasswordValidation(
  hasLowerCase: hasLowerCase,
  hasUpperCase: hasUpperCase,
  hasSpecialCharacters: hasSpecial,
  hasNumber: hasNumber,
  hasMinLength: hasMinLength,
)

// Typically used with a password controller
String password = passwordController.text;
PasswordValidation(
  hasLowerCase: AppRegex.hasLowerCase(password),
  hasUpperCase: AppRegex.hasUpperCase(password),
  hasSpecialCharacters: AppRegex.hasSpecialCharacter(password),
  hasNumber: AppRegex.hasNumber(password),
  hasMinLength: AppRegex.hasMinLength(password),
)
```

---

## 3. UI Components (Features)

### Home Welcome Card - `lib/features/home/ui/widgets/home_welcome_card.dart`

```dart
HomeWelcomeCard(
  state: HomeSuccess(userName: 'John', email: 'john@email.com', ...),
)
```

Displays a gradient card with user greeting and login method badge.

### Home Result Card - `lib/features/home/ui/widgets/home_result_card.dart`

```dart
HomeResultCard(
  data: uploadState.data, // UploadVideoResponseModel
)
```

Shows analysis results with engaged/not-engaged status indicator.

### Navigation Item - `lib/features/home/ui/widgets/nav_item.dart`

```dart
NavItem(
  title: "Home",
  icon: Icons.home_rounded,
  isActive: currentIndex == 0,
  onTap: () => setState(() => currentIndex = 0),
)
```

Animated navigation bar item with active state styling.

### Settings Section - `lib/features/home/ui/widgets/settings_section.dart`

```dart
SettingsSection(
  title: "Dark Mode",
  leading: Icon(Icons.dark_mode),
  trailing: Switch(value: isDark, onChanged: toggleTheme),
  onTap: () {},
)
```

Reusable settings list tile component.

### Analyze Button - `lib/features/home/ui/widgets/analyze_button.dart`

```dart
AnalyzeButton(
  isLoading: uploadState is UploadVideoLoading,
  onTap: selectedVideo != null ? () => uploadVideo() : null,
)
```

Gradient button with loading indicator for video analysis.

### Video Upload Section - `lib/features/home/ui/widgets/video_upload_section.dart`

```dart
VideoUploadSection(
  onVideoSelected: (File? file) {
    setState(() => selectedVideo = file);
  },
)
```

Section wrapper with title for video upload widget.

### Onboarding Page - `lib/features/onboarding/ui/widgets/onboarding_page.dart`

```dart
OnboardingPage(
  icon: Icons.face_retouching_off,
  title: 'Emotion Detection',
  description: 'Analyze facial emotions in real-time',
  color: AppColors.primary,
)
```

Onboarding page with centered icon, title, and description.

### Login Logo and App Name - `lib/features/auth/ui/widgets/login_logo_and_app_name.dart`

```dart
LoginLogoAndAppName(
  title: 'EmoVision', // Default
)
```

Displays app logo with the app name.

### Custom Login Method - `lib/features/auth/ui/widgets/custom_login_method.dart`

```dart
CustomLoginMethod(
  iconPath: AppAssets.googleIcon,
  title: 'Google',
  onTap: () => signInWithGoogle(),
)
```

Social login button with SVG icon.

### Or Login With - `lib/features/auth/ui/widgets/or_login_with_widget.dart`

```dart
OrLoginWith()
```

Shows "Or login with" divider text between form and social buttons.

---

## 4. Constants & Enums

### Routes - `lib/core/routing/routes.dart`

```dart
// Route names
Routes.onBoardingScreen      // '/onBoardingScreen'
Routes.loginScreen           // '/loginScreen'
Routes.registerScreen        // '/registerScreen'
Routes.homeScreen            // '/homeScreen'
Routes.biometricLoginScreen  // '/biometricLoginScreen'
Routes.forgotPasswordScreen  // '/forgotPasswordScreen'
Routes.resetPasswordScreen   // '/resetPasswordScreen'
```

### Shared Pref Keys - `lib/core/helpers/constants.dart`

```dart
SharedPrefKeys.userToken  // 'userToken'
```

### Cache Constants - `lib/core/constant/cache_constants.dart`

```dart
// Check file for cache key constants
```

---

## 5. Utilities

### Spacing Helpers - `lib/core/helpers/spacing.dart`

```dart
// Vertical spacing
SizedBox(height: 16.h) == verticalSpace(16)

// Horizontal spacing  
SizedBox(width: 8.w) == horizontalSpace(8)

// Usage in widgets
Column(
  children: [
    Text('Title'),
    verticalSpace(8),
    Text('Subtitle'),
  ],
)
```

### Extensions - `lib/core/helpers/extensions.dart`

```dart
// Navigation
context.pushNamed(Routes.loginScreen)
context.pushReplacementNamed(Routes.homeScreen)
context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (r) => false)
context.pop()

// String null check
String? email;
email.isNullOrEmpty() // true if null or empty

// List null check
List? items;
items.isNullOrEmpty() // true if null or empty list
```

### Validation - `lib/core/helpers/app_regex.dart`

```dart
// Email validation
if (AppRegex.isEmailValid(email)) { /* valid */ }

// Password validation
if (AppRegex.isPasswordValid(password)) { /* valid */ }

// Phone validation (Egyptian format)
if (AppRegex.isPhoneNumberValid(phone)) { /* valid */ }

// Individual password checks
AppRegex.hasLowerCase(password)
AppRegex.hasUpperCase(password)
AppRegex.hasNumber(password)
AppRegex.hasSpecialCharacter(password)
AppRegex.hasMinLength(password)
```

### Assets - `lib/core/helpers/app_assets.dart`

```dart
AppAssets.appLogo                  // 'assets/images/login_screen/app_logo.png'
AppAssets.loginScreenHead          // 'assets/images/login_screen/head.png'
AppAssets.lottieLoadingAnimation   // 'assets/lottie/loading_animation.json'
AppAssets.googleIcon             // "assets/svgs/google_icon.svg"
AppAssets.facebookIcon           // "assets/svgs/facebook_icon.svg"
AppAssets.biometric              // "assets/svgs/biometric.svg"
```

### Theme Cubit - `lib/core/theming/cubit/theme_cubit.dart`

```dart
// Get current theme
ThemeCubit.get(context).state // ThemeMode.light or ThemeMode.dark

// Toggle theme
ThemeCubit.get(context).toggleTheme(true) // Enable dark mode

// Load saved theme
ThemeCubit.get(context).loadTheme()
```

### Enhanced Dialog - `lib/core/helpers/functions.dart`

```dart
showEnhancedDialog(
  context: context,
  isError: false,
  message: 'Operation completed successfully',
  successTitle: 'Success',
)

showEnhancedDialog(
  context: context,
  isError: true,
  message: 'Invalid credentials',
  statusCode: 401,
  errors: ['Email not found', 'Try again'],
)
```

---

## 6. Quick Reference: Replacing Hardcoded Values

| Hardcoded Value | Replace With |
|----------------|--------------|
| `Color(0xff1D61E7)` | `AppColors.primary` |
| `Color(0xff000000)` | `AppColors.black` |
| `Color(0xffffffff)` | `AppColors.white` |
| `Color(0xffef4444)` | `AppColors.error` |
| `Color(0xff10b981)` | `AppColors.success` |
| `TextStyle(fontSize: 16, fontWeight: FontWeight.bold)` | `AppTextTheme.font16WhiteMedium` or appropriate variant |
| `FontWeight.w600` | `FontWeightHelper.semiBold` |
| `BorderRadius.circular(16)` | `BorderRadius.circular(16.r)` (ScreenUtil aware) |
| `SizedBox(height: 16)` | `verticalSpace(16)` or `SizedBox(height: 16.h)` |
| `SizedBox(width: 8)` | `horizontalSpace(8)` or `SizedBox(width: 8.w)` |
| `Navigator.pushNamed(context, '/login')` | `context.pushNamed(Routes.loginScreen)` |

---

## 7. Feature Folder Patterns

### Home Feature Widgets Location

All home screen widgets are in: `lib/features/home/ui/widgets/`

| Widget | File | Purpose |
|--------|------|---------|
| HomeWelcomeCard | `home_welcome_card.dart` | User greeting with gradient background |
| HomeHeader | `home_header.dart` | App bar/header section |
| NavItem | `nav_item.dart` | Bottom navigation item |
| HomeAnalyzeSection | `home_analyze_section.dart` | Main analysis workflow |
| AnalyzeButton | `analyze_button.dart` | Gradient action button |
| VideoUploadSection | `video_upload_section.dart` | Video picker section |
| HomeResultCard | `home_result_card.dart` | Analysis result display |
| SettingsSection | `settings_section.dart` | Settings list tile |

### Auth Feature Widgets Location

All auth widgets are in: `lib/features/auth/ui/widgets/`

| Widget | File | Purpose |
|--------|------|---------|
| CustomButton | `custom_button.dart` | Reusable auth button |
| PhoneTextField | `phone_text_field.dart` | International phone input |
| OtpPinField | `otp_pin_field.dart` | OTP input with auto-submit |
| OrLoginWith | `or_login_with_widget.dart` | "Or login with" divider |
| CustomLoginMethod | `custom_login_method.dart` | Social login button |
| LoginLogoAndAppName | `login_logo_and_app_name.dart` | Brand header |
| LoginRegisterScreenHeaderColumn | Header component | Screen header |
| DontHaveAlreadyHaveAccountWidget | Toggle between login/register |

---

## 8. Common Usage Patterns

### Adding a new screen to navigation:

```dart
// 1. Add route constant
// lib/core/routing/routes.dart
static const String newScreen = '/newScreen';

// 2. Add route in router
// lib/core/routing/app_router.dart
case Routes.newScreen:
  return MaterialPageRoute(builder: (_) => const NewScreen());

// 3. Navigate
context.pushNamed(Routes.newScreen);
```

### Creating a themed widget:

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  
  return Container(
    color: theme.scaffoldBackgroundColor,
    child: Text(
      'Hello',
      style: theme.textTheme.headlineMedium,
    ),
  );
}
```

### Using validators with form fields:

```dart
AppTextFormField(
  hintText: 'Email',
  controller: emailController,
  validator: (value) {
    if (value.isNullOrEmpty()) return 'Email is required';
    if (!AppRegex.isEmailValid(value)) return 'Invalid email format';
    return null;
  },
)
```