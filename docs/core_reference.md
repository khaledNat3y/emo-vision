# Core Reference Guide

Quick reference for presentation-layer work using `lib/core/`: design tokens, reusable widgets, dialogs, routing helpers, constants, and utilities.

## File Structure Overview

```text
lib/core/
|-- constant/
|   |-- cache_constants.dart
|   `-- firebase_constants.dart
|-- di/
|   `-- dependency_injection.dart
|-- helpers/
|   |-- app_assets.dart
|   |-- app_regex.dart
|   |-- app_startup.dart
|   |-- constants.dart
|   |-- extensions.dart
|   |-- functions.dart
|   |-- logger.dart
|   |-- shared_pref_helper.dart
|   `-- spacing.dart
|-- networking/
|   |-- api_constant.dart
|   |-- api_error_handler.dart
|   `-- dio_helper.dart
|-- routing/
|   |-- app_router.dart
|   |-- router_transitions.dart
|   `-- routes.dart
|-- services/
|   |-- biometric_service.dart
|   |-- firebase_services.dart
|   `-- auth_service.dart
|-- theming/
|   |-- app_colors.dart
|   |-- app_text_theme.dart
|   |-- app_theme.dart
|   `-- font_weight_helper.dart
`-- widgets/
    |-- app_text_form_field.dart
    |-- custom_btn.dart
    |-- password_validation.dart
    `-- video_upload_widget.dart
```

## Design System

### AppColors

File: `lib/core/theming/app_colors.dart`

`AppColors` is the main color token source.

| Token group | Tokens |
| --- | --- |
| Light surfaces | `backgroundLight`, `surfaceLight`, `borderLight`, `dividerLight` |
| Light text | `textPrimaryLight`, `grey`, `textTertiaryLight` |
| Dark surfaces | `backgroundDark`, `surfaceDark`, `borderDark`, `dividerDark` |
| Dark text | `textPrimaryDark`, `textSecondaryDark`, `textTertiaryDark` |
| Brand/status | `primary`, `primaryDark`, `secondary`, `tertiary`, `success`, `error`, `warning` |
| Base | `white`, `black` |

```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.surfaceLight,
    border: Border.all(color: AppColors.borderLight),
  ),
  child: Text(
    'Profile',
    style: Theme.of(context).textTheme.titleLarge,
  ),
);
```

### AppTextStyles / AppTextTheme

File: `lib/core/theming/app_text_theme.dart`

There is no `AppTextStyles` class. The current class is `AppTextTheme`.

Available static styles:

```dart
AppTextTheme.font24BlackBold
AppTextTheme.font14BlackSemiBold
AppTextTheme.font12GreyMedium
AppTextTheme.font12BlueRegular
AppTextTheme.font13BlackRegular
AppTextTheme.font16WhiteMedium
AppTextTheme.font24WhiteBold
AppTextTheme.font12RegularPrimary
AppTextTheme.font13WhiteRegular
AppTextTheme.font16PrimaryMedium
AppTextTheme.font20BoldPrimary
AppTextTheme.font18MediumSecondary
AppTextTheme.font14RegularTertiary
```

```dart
Text(
  'Welcome back',
  style: AppTextTheme.font24BlackBold,
);

Text(
  'Forgot password?',
  style: AppTextTheme.font12BlueRegular,
);
```

Prefer theme styles when the text should adapt between light and dark mode:

```dart
Text(
  'Email address',
  style: Theme.of(context).textTheme.bodyMedium,
);
```

Theme styles are defined in `lib/core/theming/app_theme.dart` for `displayLarge`, `displayMedium`, `headlineLarge`, `headlineMedium`, `headlineSmall`, `titleLarge`, `titleMedium`, `titleSmall`, `bodyLarge`, `bodyMedium`, and `bodySmall`.

### AppSpacing

File: `lib/core/helpers/spacing.dart`

There is no `AppSpacing` class. Use the spacing helpers and `flutter_screenutil` extensions.

```dart
Column(
  children: [
    Text('Title'),
    verticalSpace(16),
    Text('Subtitle'),
  ],
);

Row(
  children: [
    const Icon(Icons.email),
    horizontalSpace(8),
    Expanded(child: AppTextFormField(...)),
  ],
);
```

Some screens also use extension syntax such as `16.verticalSpace` and `8.horizontalSpace`; those come from `flutter_screenutil`.

### AppRadius

No `AppRadius` class exists yet. Current radius values are hardcoded where needed.

Common values already used:

| Radius | Current usage |
| --- | --- |
| `8.r` | Theme buttons, dialog action button |
| `10.0` | `AppTextFormField` enabled border |
| `16.0` | `AppTextFormField` focused/error borders, enhanced dialog |
| `24.r` | `VideoUploadWidget` card container |
| `50` / `50.r` | Pill buttons |

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
  ),
);
```

### Shadows

There is no global shadow token class. `VideoUploadWidget` defines a local soft primary shadow:

```dart
boxShadow: [
  BoxShadow(
    color: AppColors.primary.withAlpha(25),
    blurRadius: 20,
    offset: const Offset(0, 8),
  ),
],
```

### Font Weights

File: `lib/core/theming/font_weight_helper.dart`

Use `FontWeightHelper` instead of raw `FontWeight` values when matching the app style:

```dart
TextStyle(
  fontWeight: FontWeightHelper.semiBold,
);
```

Available: `thin`, `extraLight`, `light`, `regular`, `medium`, `semiBold`, `bold`, `extraBold`.

### AppTheme

File: `lib/core/theming/app_theme.dart`

`AppTheme.lightMode` and `AppTheme.darkMode` configure Material 3, League Spartan, scaffold backgrounds, color schemes, button themes, and text themes.

```dart
MaterialApp(
  theme: AppTheme.lightMode,
  darkTheme: AppTheme.darkMode,
  onGenerateRoute: AppRouter.generateRoute,
);
```

## Core Widgets

### CustomBtn

File: `lib/core/widgets/custom_btn.dart`

Full-width rounded gradient button.

Key API:

```dart
CustomBtn({
  required String title,
  void Function()? onTap,
  bool? isLoading,
})
```

Usage:

```dart
CustomBtn(
  title: 'Login',
  isLoading: state is LoginLoading,
  onTap: () => formKey.currentState?.validate(),
);
```

Notes:

| Behavior | Detail |
| --- | --- |
| Height | `MediaQuery.sizeOf(context).height * 0.0786` |
| Text | `AppTextTheme.font16WhiteMedium` |
| Gradient | `AppColors.primary` to `AppColors.primaryDark` |
| Loading color | Grey gradient when `isLoading == true` |

### AppTextFormField

File: `lib/core/widgets/app_text_form_field.dart`

Styled `TextFormField` wrapper for auth/profile forms.

Key API:

```dart
AppTextFormField({
  String? hintText,
  bool? isObscureText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Color? backgroundColor,
  TextEditingController? controller,
  required Function(String?) validator,
  FocusNode? focusNode,
  bool? isReadOnly,
  String? initialValue,
  EdgeInsetsGeometry? contentPadding,
  InputBorder? focusedBorder,
  InputBorder? enabledBorder,
  TextStyle? inputTextStyle,
  TextStyle? hintStyle,
})
```

Usage:

```dart
AppTextFormField(
  controller: emailController,
  hintText: 'Email',
  prefixIcon: const Icon(Icons.email_outlined),
  validator: (value) {
    if (!AppRegex.isEmailValid(value ?? '')) {
      return 'Enter a valid email';
    }
    return null;
  },
);
```

For passwords:

```dart
AppTextFormField(
  controller: passwordController,
  hintText: 'Password',
  isObscureText: true,
  suffixIcon: const Icon(Icons.visibility_off_outlined),
  validator: (value) =>
      AppRegex.isPasswordValid(value ?? '') ? null : 'Weak password',
);
```

### PasswordValidation

File: `lib/core/widgets/password_validation.dart`

Displays live password requirements using dots and check icons.

Key API:

```dart
PasswordValidation({
  required bool hasLowerCase,
  required bool hasUpperCase,
  required bool hasSpecialCharacters,
  required bool hasNumber,
  required bool hasMinLength,
})
```

Usage:

```dart
PasswordValidation(
  hasLowerCase: AppRegex.hasLowerCase(password),
  hasUpperCase: AppRegex.hasUpperCase(password),
  hasSpecialCharacters: AppRegex.hasSpecialCharacter(password),
  hasNumber: AppRegex.hasNumber(password),
  hasMinLength: AppRegex.hasMinLength(password),
);
```

### VideoUploadWidget

File: `lib/core/widgets/video_upload_widget.dart`

Interactive video picker for selecting, changing, and removing a gallery video.

Key API:

```dart
VideoUploadWidget({
  Function(File?)? onVideoSelected,
  String? initialVideoPath,
  String title = 'Upload Video',
  String subtitle = 'Tap to select a video from your gallery',
})
```

Usage:

```dart
File? selectedVideo;

VideoUploadWidget(
  title: 'Upload interview video',
  subtitle: 'Choose a video up to 10 minutes',
  onVideoSelected: (file) {
    selectedVideo = file;
  },
);
```

States:

| State | UI |
| --- | --- |
| Empty | Upload prompt with video icon and Browse Gallery button |
| Loading | Circular progress indicator |
| Selected | Success icon, filename, Change and Remove actions |
| Error | `SnackBar` with `AppColors.error` |

## UI Components

### Enhanced Dialog

File: `lib/core/helpers/functions.dart`

Reusable success/error dialog.

Key API:

```dart
showEnhancedDialog({
  required BuildContext context,
  required bool isError,
  required String message,
  int? statusCode,
  List<String> errors = const [],
  IconData? icon,
  String? successTitle,
  String? errorTitle,
})
```

Error usage:

```dart
showEnhancedDialog(
  context: context,
  isError: true,
  statusCode: 400,
  message: 'Please check your input.',
  errors: ['Email is required', 'Password is too short'],
);
```

Success usage:

```dart
showEnhancedDialog(
  context: context,
  isError: false,
  successTitle: 'Account created',
  message: 'You can now sign in.',
);
```

Behavior:

| Status | Title/help behavior |
| --- | --- |
| `400` | Validation Error |
| `401` | Authentication Failed |
| `403` | Access Denied |
| `404` | Not Found |
| `>= 500` | Server Error |
| success | Uses `successTitle` or `Success` |

### Route Transitions

File: `lib/core/routing/router_transitions.dart`

Helpers for custom route animations:

```dart
Navigator.of(context).push(
  RouterTransitions.buildHorizontal(const LoginScreen()),
);

Navigator.of(context).push(
  RouterTransitions.buildFade(const HomeScreen()),
);
```

Available builders: `buildVertical`, `buildHorizontal`, `buildFade`, `buildScale`, and plain `build`.

## Constants And Enums

No enums were found in `lib/core/`. Constants are grouped below.

### Routes

File: `lib/core/routing/routes.dart`

```dart
context.pushNamed(Routes.loginScreen);
context.pushNamed(
  Routes.otpScreen,
  arguments: {'email': email},
);
```

Available route names:

```dart
Routes.onBoardingScreen
Routes.loginScreen
Routes.registerScreen
Routes.otpScreen
Routes.otpSuccessScreen
Routes.homeScreen
Routes.biometricLoginScreen
Routes.forgotPasswordScreen
Routes.resetPasswordScreen
```

Note: `Routes.registerScreen` is currently `'registerScreen'` without a leading slash, unlike the other routes.

### Cache Constants

File: `lib/core/constant/cache_constants.dart`

Global startup flags:

```dart
isFirstLaunch
isBiometric
isUserLoggedInWithGoogle
isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken
```

Storage keys:

```dart
CacheConstants.accessToken
CacheConstants.refreshToken
CacheConstants.userEmail
CacheConstants.userEmailFromGoogle
CacheConstants.userName
CacheConstants.userPhotoUrl
CacheConstants.signInWithGoogle
CacheConstants.isBiometricLogin
CacheConstants.hasSeenOnboarding
CacheConstants.phoneNumber
```

Usage:

```dart
await SharedPrefHelper.setData(
  CacheConstants.hasSeenOnboarding,
  true,
);
```

### Shared Pref Keys

File: `lib/core/helpers/constants.dart`

```dart
isLoggedInUser
SharedPrefKeys.userToken
```

### Firebase Constants

File: `lib/core/constant/firebase_constants.dart`

```dart
FirebaseConstants.usersCollection
```

Usage:

```dart
FirebaseFirestore.instance
    .collection(FirebaseConstants.usersCollection)
    .doc(uid);
```

### API Constants

File: `lib/core/networking/api_constant.dart`

```dart
ApiConstants.baseUrl
ApiConstants.login
ApiConstants.register
ApiConstants.verifyEmail
ApiConstants.logout
ApiConstants.me
ApiConstants.refreshToken
ApiConstants.forgotPassword
ApiConstants.resetPassword
ApiConstants.resendOtp
```

## Utilities

### Validators

File: `lib/core/helpers/app_regex.dart`

```dart
AppRegex.isEmailValid('name@example.com');
AppRegex.isPasswordValid('Password1!');
AppRegex.isPhoneNumberValid('01012345678');

AppRegex.hasLowerCase(password);
AppRegex.hasUpperCase(password);
AppRegex.hasNumber(password);
AppRegex.hasSpecialCharacter(password);
AppRegex.hasMinLength(password);
```

### Assets

File: `lib/core/helpers/app_assets.dart`

```dart
Image.asset(AppAssets.appLogo);
Image.asset(AppAssets.loginScreenHead);

Lottie.asset(AppAssets.lottieLoadingAnimation);

SvgPicture.asset(AppAssets.googleIcon);
SvgPicture.asset(AppAssets.facebookIcon);
SvgPicture.asset(AppAssets.biometric);
```

Available asset tokens:

```dart
AppAssets.appLogo
AppAssets.loginScreenHead
AppAssets.lottieLoadingAnimation
AppAssets.googleIcon
AppAssets.facebookIcon
AppAssets.biometric
```

### Navigation Extensions

File: `lib/core/helpers/extensions.dart`

```dart
context.pushNamed(Routes.homeScreen);
context.pushReplacementNamed(Routes.loginScreen);
context.pushNamedAndRemoveUntil(
  Routes.loginScreen,
  predicate: (_) => false,
);
context.pop();
```

### Null/Empty Extensions

File: `lib/core/helpers/extensions.dart`

```dart
String? value;
if (value.isNullOrEmpty()) {
  return 'Required';
}

List<String>? items;
if (items.isNullOrEmpty()) {
  return const EmptyState();
}
```

### Form Auto Scroll

File: `lib/core/helpers/extensions.dart`

Validates a form and scrolls the first invalid field into view.

```dart
final formKey = GlobalKey<FormState>();

if (formKey.validateAndScroll()) {
  // Submit form
}
```

### Shared Preferences Helper

File: `lib/core/helpers/shared_pref_helper.dart`

```dart
await SharedPrefHelper.setData(CacheConstants.userName, 'Khaled');
final userName = await SharedPrefHelper.getString(CacheConstants.userName);

await SharedPrefHelper.setSecuredString(
  CacheConstants.accessToken,
  token,
);
final token = await SharedPrefHelper.getSecuredString(
  CacheConstants.accessToken,
);

await SharedPrefHelper.removeData(CacheConstants.userEmail);
await SharedPrefHelper.clearAllData();
await SharedPrefHelper.clearAllSecuredData();
```

Getters:

```dart
SharedPrefHelper.getBool(key)
SharedPrefHelper.getBoolOrNull(key)
SharedPrefHelper.getDouble(key)
SharedPrefHelper.getInt(key)
SharedPrefHelper.getString(key)
SharedPrefHelper.getSecuredString(key)
```

### Logger

File: `lib/core/helpers/logger.dart`

Logs only when `appFlavor == 'development'`.

```dart
Logger.log('Opened home screen');
Logger.debug('Form value: $value');
Logger.info('Loading profile');
Logger.success('Saved successfully');
Logger.warning('Missing optional image');
Logger.error('Failed to save', error, stackTrace);
```

### App Startup

File: `lib/core/helpers/app_startup.dart`

Initializes Flutter bindings, Firebase, dependency injection, ScreenUtil, system UI styling, and startup auth flags.

```dart
Future<void> main() async {
  await initializeApp();
  runApp(const EmoVisionApp());
}
```

### API Error Handling

File: `lib/core/networking/api_error_handler.dart`

Turns `DioException` values into user-readable messages.

```dart
try {
  await DioHelper.postRequest(
    endPoint: ApiConstants.login,
    data: body,
  );
} on DioException catch (error) {
  final message = ApiErrorHandler.handle(error);
  showEnhancedDialog(
    context: context,
    isError: true,
    message: message,
    statusCode: error.response?.statusCode,
  );
}
```

### Dio Helper

File: `lib/core/networking/dio_helper.dart`

Provides a configured Dio instance with base URL, logging, auth token attachment, token refresh, and request helpers.

```dart
final response = await DioHelper.getRequest(
  endPoint: ApiConstants.me,
);

await DioHelper.postRequest(
  endPoint: ApiConstants.login,
  data: {
    'email': email,
    'password': password,
  },
);
```

Available methods: `getRequest`, `postRequest`, `putRequest`, `deleteRequest`.

### Services For Presentation Flows

Files:

```text
lib/core/services/biometric_service.dart
lib/core/services/firebase_services.dart
lib/core/di/dependency_injection.dart
```

Use `getIt` to access registered services/cubits from UI setup code:

```dart
final biometricService = getIt<BiometricService>();
final isAvailable = await biometricService.isAvailable();

if (isAvailable) {
  final ok = await biometricService.authenticate();
}
```

Registered dependencies include `AuthService`, `FirebaseServices`, `BiometricService`, `AuthRepo`, `LoginCubit`, `RegisterCubit`, `OtpCubit`, `HomeCubit`, and `LogoutCubit`.

## Quick Reference For Replacing Hardcoded Values

| Hardcoded value | Prefer |
| --- | --- |
| `Colors.blue` | `AppColors.primary` |
| `Colors.red` | `AppColors.error` |
| `Colors.green` | `AppColors.success` |
| `Colors.orange` | `AppColors.warning` |
| `Colors.white` | `AppColors.white` |
| `Colors.black` | `AppColors.black` |
| `Color(0xff...)` | Add or reuse an `AppColors` token |
| `FontWeight.w600` | `FontWeightHelper.semiBold` |
| `FontWeight.bold` | `FontWeightHelper.bold` |
| `SizedBox(height: 16.h)` | `verticalSpace(16)` |
| `SizedBox(width: 8.w)` | `horizontalSpace(8)` |
| Raw route string | `Routes.someScreen` |
| Raw asset path | `AppAssets.someAsset` |
| Raw storage key | `CacheConstants.someKey` or `SharedPrefKeys.someKey` |
| Manual email/password regex | `AppRegex` methods |
| Manual `Navigator.of(context)` calls | `context.pushNamed`, `context.pop`, etc. |
| Custom error `AlertDialog` | `showEnhancedDialog(...)` |

## Common Presentation Patterns

### Form With Validation And Auto Scroll

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: Column(
    children: [
      AppTextFormField(
        controller: emailController,
        hintText: 'Email',
        validator: (value) =>
            AppRegex.isEmailValid(value ?? '') ? null : 'Invalid email',
      ),
      verticalSpace(16),
      CustomBtn(
        title: 'Continue',
        onTap: () {
          if (formKey.validateAndScroll()) {
            context.pushNamed(Routes.otpScreen, arguments: {
              'email': emailController.text,
            });
          }
        },
      ),
    ],
  ),
);
```

### Error Flow

```dart
showEnhancedDialog(
  context: context,
  isError: true,
  message: ApiErrorHandler.handle(error),
  statusCode: error.response?.statusCode,
);
```

### Success Flow

```dart
showEnhancedDialog(
  context: context,
  isError: false,
  successTitle: 'Done',
  message: 'Your changes were saved.',
);
```

### Theme-Aware Text And Color

```dart
Text(
  'Home',
  style: Theme.of(context).textTheme.headlineMedium,
);

Container(
  color: Theme.of(context).colorScheme.surface,
);
```
