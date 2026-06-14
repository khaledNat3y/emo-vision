# Features Presentation Layer Reference

## Auth Feature - `lib/features/auth/`

### Screens

| Screen | File Path | Purpose |
|--------|-----------|---------|
| Login | `lib/features/auth/ui/login_screen.dart` | User login with email/password + social options |
| Register | `lib/features/auth/ui/register_screen.dart` | New user registration |
| Forgot Password | `lib/features/auth/ui/forgot_password_screen.dart` | Password reset request |
| Reset Password | `lib/features/auth/ui/reset_password_screen.dart` | Set new password |
| Biometric Login | `lib/features/auth/ui/biometric_login_screen.dart` | Fingerprint/Face ID login |

### Auth Widgets - `lib/features/auth/ui/widgets/`

#### CustomButton - `custom_button.dart`

Fully customizable gradient button with loading state.

```dart
CustomButton(
  text: 'Sign In',
  onPressed: () => login(),
  isLoading: false,
  radius: 50, // Optional: default 50
  color: AppColors.primary, // Optional: uses primary gradient
  textStyle: AppTextTheme.font16WhiteMedium, // Optional
)
```

#### PhoneTextField - `phone_text_field.dart`

International phone input with Egyptian validation (auto-adjusted).

```dart
PhoneTextField(
  controller: phoneController,
  onChanged: (phone) {
    // phone.countryCode, phone.number
  },
  validator: (phone) {
    // Default validates Egyptian numbers (010, 011, 012, 015 prefixes)
    return null; // or custom error
  },
)
```

#### OtpPinField - `otp_pin_field.dart`

OTP input field with auto-submit support.

```dart
OtpPinField(
  controller: otpController,
  length: 6,
  onCompleted: () {
    // Called when all digits entered
    verifyOtp();
  },
  onChanged: (value) {
    // Real-time updates
  },
)
```

#### CustomLoginMethod - `custom_login_method.dart`

Social login button (Google, Facebook, etc.).

```dart
CustomLoginMethod(
  iconPath: AppAssets.googleIcon,
  title: 'Google',
  onTap: () => signInWithGoogle(),
)
```

#### OrLoginWith - `or_login_with_widget.dart`

Divider with "Or login with" text.

```dart
OrLoginWith() // Place between form and social buttons
```

#### LoginLogoAndAppName - `login_logo_and_app_name.dart`

App branding header.

```dart
LoginLogoAndAppName(title: 'EmoVision') // Default title
```

#### DontHaveAlreadyHaveAccountWidget - `dont_have_already_have_account_widget.dart`

Toggle between login/register screens with clickable text.

```dart
DontHaveAlreadyHaveAccountWidget(
  title: 'Don\'t have an account? ', // Default for login screen
  subtitle: 'Sign Up',
  onTap: () => navigateToRegister(),
)
```

**Properties:**
- `title` - Leading text (e.g., "Already have an account? ")
- `subtitle` - Action text (e.g., "Sign In")
- `onTap` - Navigation callback

### Auth Logo and App Name Widget Usage

```dart
// In login/register screens
Column(
  children: [
    LoginLogoAndAppName(),
    SizedBox(height: 24.h),
    Text('Welcome Back'),
  ],
)
```

---

## Home Feature - `lib/features/home/`

### Screens

| Screen | File Path | Purpose |
|--------|-----------|---------|
| Home | `lib/features/home/ui/home_screen.dart` | Main dashboard with analysis |
| Settings | `lib/features/home/ui/settings_screen.dart` | User settings/preferences |

### Home Widgets - `lib/features/home/ui/widgets/`

#### HomeWelcomeCard - `home_welcome_card.dart`

Gradient welcome card showing user greeting.

```dart
HomeWelcomeCard(
  state: HomeSuccess(
    userName: 'John Doe',
    email: 'john@example.com',
    photoUrl: '', // optional
    isBiometric: false,
  ),
)
```

**State Properties Required:**
- `userName` - Display name
- `email` - User email
- `photoUrl` - Profile image URL (Google login)
- `isBiometric` - True if biometric login (shows restriction message)

#### HomeHeader - `home_header.dart`

Screen header with notification and logout actions.

```dart
HomeHeader(
  state: HomeSuccess(...),
  onLogoutTap: () => showLogoutDialog(context),
)
```

#### NavItem - `nav_item.dart`

Bottom navigation bar item.

```dart
NavItem(
  title: "Home",
  icon: Icons.home_rounded,
  isActive: currentIndex == 0,
  onTap: () => setState(() => currentIndex = 0),
)
```

**Properties:**
- `title` - Item label
- `icon` - Icon data
- `isActive` - Highlight state
- `onTap` - Click handler

#### HomeAnalyzeSection - `home_analyze_section.dart`

Main analysis workflow container.

```dart
HomeAnalyzeSection(
  resultKey: GlobalKey(), // For auto-scroll to results
)
```

Contains video upload and analyze button.

#### AnalyzeButton - `analyze_button.dart`

Gradient action button for video analysis.

```dart
AnalyzeButton(
  isLoading: uploadState is UploadVideoLoading,
  onTap: selectedVideo != null ? () => uploadVideo() : null,
)
```

#### VideoUploadSection - `video_upload_section.dart`

Video picker section wrapper.

```dart
VideoUploadSection(
  onVideoSelected: (File? file) {
    setState(() => selectedVideo = file);
  },
)
```

#### HomeResultCard - `home_result_card.dart`

Displays emotion analysis results.

```dart
HomeResultCard(
  data: UploadVideoResponseModel(
    prediction: 'engaged', // or 'not engaged'
    metadata: Metadata(totalFrames: 150),
  ),
)
```

**Result Display:**
- Green badge for "engaged" prediction
- Red badge for "not engaged" prediction
- Shows frame count if available

#### SettingsSection - `settings_section.dart`

Reusable settings list tile.

```dart
SettingsSection(
  title: "Dark Mode",
  titleColor: Colors.black, // Optional: default uses theme
  leading: Icon(Icons.dark_mode),
  trailing: Switch(value: isDark, onChanged: toggleTheme),
  onTap: () {},
)
```

---

## Onboarding Feature - `lib/features/onboarding/`

### Screens

| Screen | File Path | Purpose |
|--------|-----------|---------|
| Onboarding | `lib/features/onboarding/ui/onboarding_screen.dart` | App introduction slides |

### Onboarding Widgets - `lib/features/onboarding/ui/widgets/`

#### OnboardingPage - `onboarding_page.dart`

Single onboarding page content.

```dart
OnboardingPage(
  icon: Icons.face_retouching_off,
  title: 'Emotion Detection',
  description: 'Analyze facial emotions in real-time',
  color: AppColors.primary,
)
```

#### OnboardingButtons - `onboarding_buttons.dart`

Navigation buttons for onboarding flow (Next/Get Started/Skip).

```dart
OnboardingButtons(
  currentPage: currentPage,
  pageController: pageController,
)
```

**Properties:**
- `currentPage` - Current page index (0, 1, or 2)
- `pageController` - PageView scroll controller

#### SmoothPageIndicatorWidget - `smooth_page_indicator_widget.dart`

Dots indicator for page view with color transitions.

```dart
SmoothPageIndicatorWidget(
  pageController: pageController,
  currentPage: currentPage,
)
```

**Note:** Takes `pageController` and `currentPage` as positional parameters (not named).

---

## State Management (Cubits)

### Auth Cubits

| Cubit | File Path | Purpose |
|-------|-----------|---------|
| LoginCubit | `lib/features/auth/logic/login_cubit/login_cubit.dart` | Login flow |
| RegisterCubit | `lib/features/auth/logic/register_cubit/register_cubit.dart` | Registration |
| LogoutCubit | `lib/features/auth/logic/logout_cubit/logout_cubit.dart` | Logout handling |
| ForgotPasswordCubit | `lib/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart` | Password reset |

### Home Cubits

| Cubit | File Path | Purpose |
|-------|-----------|---------|
| HomeCubit | `lib/features/home/logic/cubit/home_cubit.dart` | Home state management |
| UploadVideoCubit | `lib/features/home/logic/cubit/upload_video_cubit.dart` | Video upload flow |

### Using Cubits in UI

```dart
// Provider setup (in screen)
BlocProvider(
  create: (_) => getIt<LoginCubit>(),
  child: LoginScreenBody(),
)

// Listening to state changes
BlocListener<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) {
      context.pushNamedAndRemoveUntil(Routes.homeScreen);
    }
  },
  child: child,
)

// Reading state in builder
BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    final isLoading = state is LoginLoading;
    return CustomButton(
      text: 'Login',
      isLoading: isLoading,
      onTap: isLoading ? null : () => login(),
    );
  },
)
```

---

## Models

### Auth Models - `lib/features/auth/data/models/`

| Model | File | Properties |
|-------|------|------------|
| LoginRequestBody | `login_request_body.dart` | email, password |
| LoginResponse | `login_response.dart` | token, user info |
| RegisterRequestBody | `register_request_body.dart` | name, email, phone, password |
| RegisterResponse | `register_response.dart` | user data |
| ForgotPasswordRequestBody | `forgot_password_request_body.dart` | email |
| ResetPasswordRequestBody | `reset_password_request_body.dart` | email, otp, password |
| VerifyEmailRequestBody | `verify_email_request_body.dart` | email, otp |
| LogoutRequestBody | `logout_request_body.dart` | token |
| MeResponse | `me_response.dart` | user profile |
| OtpErrorModel | `otp_error_model.dart` | error details |

### Home Models - `lib/features/home/data/model/`

| Model | File | Properties |
|-------|------|------------|
| UserModel | `user_model.dart` | name, email, photoUrl |
| UploadVideoRequestBody | `upload_video_request_body.dart` | video file data |
| UploadVideoResponseModel | `upload_video_response_model.dart` | prediction, metadata |
| UploadVideoResponseErrorModel | `upload_video_response_error_model.dart` | error messages |

---

## Data Layer - Repositories

### Home Repository - `lib/features/home/data/repo/`

```dart
HomeRepo(
  getIt<HomeRepo>().uploadVideo(File video),
)
```

### Upload Video Repository - `lib/features/home/data/repo/upload_video_repo.dart`

```dart
UploadVideoRepo(
  uploadVideo(
    UploadVideoRequestBody(body: requestBody),
  ),
)
```

### Auth Repository - `lib/features/auth/data/repo/auth_repo.dart`

```dart
AuthRepo(
  login(LoginRequestBody(...)),
  register(RegisterRequestBody(...)),
  logout(LogoutRequestBody(...)),
  forgotPassword(ForgotPasswordRequestBody(...)),
  resetPassword(ResetPasswordRequestBody(...)),
  verifyEmail(VerifyEmailRequestBody(...)),
)
```

---

## Bloc Listeners

### Login Bloc Listener - `lib/features/auth/ui/widgets/login_bloc_listener.dart`

Listens to login state and handles navigation.

### Register Bloc Listener - `lib/features/auth/ui/widgets/register_bloc_listener.dart`

Handles registration flow and navigation.

**Usage:**

```dart
// In auth screen
BlocListener<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) {
      context.pushNamed(Routes.homeScreen);
    }
  },
  child: LoginScreenBody(),
)
```