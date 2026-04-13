# Features Reference Guide

A complete reference for everything inside `lib/features/`, covering each feature's screens, cubits/states, models, repos, data sources, and reusable widgets.

---

## Table of Contents

- [Feature: auth](#feature-auth)
- [Feature: home](#feature-home)
- [Feature: onboarding](#feature-onboarding)

---

## Feature: auth

### Folder Structure

```
auth/
├── data/
│   ├── models/
│   │   ├── login_request_body.dart
│   │   ├── login_response.dart
│   │   ├── otp_error_model.dart
│   │   ├── register_request_body.dart
│   │   ├── register_response.dart
│   │   └── verify_email_request_body.dart
│   └── repo/
│       └── auth_repo.dart
├── logic/
│   ├── login_cubit/
│   │   ├── login_cubit.dart
│   │   └── login_state.dart
│   ├── otp_cubit/
│   │   ├── otp_cubit.dart
│   │   └── otp_state.dart
│   └── register_cubit/
│       ├── register_cubit.dart
│       └── register_state.dart
└── ui/
    ├── login_screen.dart
    ├── login_screen_body.dart
    ├── register_screen.dart
    ├── register_screen_body.dart
    ├── otp_verification_screen.dart
    ├── otp_scuccess_screen.dart
    └── widgets/
        ├── custom_button.dart
        ├── custom_login_method.dart
        ├── dont_have_already_have_account_widget.dart
        ├── login_bloc_listener.dart
        ├── login_form.dart
        ├── login_logo_and_app_name.dart
        ├── login_register_screen_header_column.dart
        ├── or_login_with_widget.dart
        ├── otp_bloc_listener.dart
        ├── phone_text_field.dart
        ├── register_bloc_listener.dart
        ├── register_form.dart
        ├── register_screen_header.dart
        └── welcom_screen.dart
```

### Cubits & States

#### LoginCubit

**File:** [`lib/features/auth/logic/login_cubit/login_cubit.dart`](lib/features/auth/logic/login_cubit/login_cubit.dart)

| State | Class | Description | Trigger |
|-------|-------|-------------|---------|
| Initial | `LoginInitial` | Initial state before any login attempt | Constructor |
| Loading | `LoginLoading` | Email/password login in progress | `login()` called |
| Google Loading | `LoginWithGoogleLoading` | Google sign-in in progress | `signInWithGoogle()` called |
| Success | `LoginSuccess` | Email/password login successful | `login()` succeeds |
| Google Success | `LoginWithGoogleSuccess` | Google sign-in successful | `signInWithGoogle()` succeeds |
| Error | `LoginError` | Login failed | `login()` or `signInWithGoogle()` fails |

**Usage Example (BlocBuilder):**

```dart
BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    if (state is LoginLoading) {
      return CircularProgressIndicator();
    }
    return CustomButton(
      text: 'Log in',
      isLoading: state is LoginLoading,
      onPressed: () {
        context.read<LoginCubit>().login(
          body: LoginRequestBody(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
      },
    );
  },
)
```

---

#### OtpCubit

**File:** [`lib/features/auth/logic/otp_cubit/otp_cubit.dart`](lib/features/auth/logic/otp_cubit/otp_cubit.dart)

| State | Class | Description | Trigger |
|-------|-------|-------------|---------|
| Initial | `OtpInitial` | Initial state before OTP verification | Constructor |
| Loading | `OtpLoading` | OTP verification in progress | `verifyOTP()` called |
| Success | `OtpSuccess` | OTP verification successful | `verifyOTP()` succeeds |
| Error | `OtpError` | OTP verification failed | `verifyOTP()` fails |

**Usage Example (BlocBuilder):**

```dart
BlocBuilder<OtpCubit, OtpState>(
  builder: (context, state) {
    return CustomBtn(
      title: state is OtpLoading ? "Verifying..." : "Confirm",
      onTap: state is OtpLoading ? null : _handleVerifyOTP,
      isLoading: state is OtpLoading,
    );
  },
)
```

---

#### RegisterCubit

**File:** [`lib/features/auth/logic/register_cubit/register_cubit.dart`](lib/features/auth/logic/register_cubit/register_cubit.dart)

| State | Class | Description | Trigger |
|-------|-------|-------------|---------|
| Initial | `RegisterInitial` | Initial state before registration | Constructor |
| Loading | `RegisterLoading` | Registration in progress | `register()` called |
| Success | `RegisterSuccess` | Registration successful | `register()` succeeds |
| Error | `RegisterError` | Registration failed | `register()` fails |

**Usage Example (BlocBuilder):**

```dart
BlocBuilder<RegisterCubit, RegisterState>(
  builder: (context, state) {
    return CustomButton(
      text: "Register",
      isLoading: state is RegisterLoading,
      onPressed: () {
        context.read<RegisterCubit>().register(
          body: RegisterRequestBody(
            email: email.text,
            password: password.text,
            firstName: firstName,
            lastName: lastName,
          ),
        );
      },
    );
  },
)
```

---

### Screens / Views

#### LoginScreen

**File:** [`lib/features/auth/ui/login_screen.dart`](lib/features/auth/ui/login_screen.dart)

| Property | Value |
|----------|-------|
| Class | `LoginScreen` |
| Route | `/login` (Routes.loginScreen) |
| Cubit Used | `LoginCubit` |
| Key UI Elements | Background image, login form, OAuth buttons (Google, Biometric), Terms text |

---

#### RegisterScreen

**File:** [`lib/features/auth/ui/register_screen.dart`](lib/features/auth/ui/register_screen.dart)

| Property | Value |
|----------|-------|
| Class | `RegisterScreen` |
| Route | `/register` (Routes.registerScreen) |
| Cubit Used | `RegisterCubit` |
| Key UI Elements | Background image, registration form with validation |

---

#### OTPVerificationScreen

**File:** [`lib/features/auth/ui/otp_verification_screen.dart`](lib/features/auth/ui/otp_verification_screen.dart)

| Property | Value |
|----------|-------|
| Class | `OTPVerificationScreen` |
| Route | `/otp` (Routes.otpScreen) |
| Cubit Used | `OtpCubit` |
| Key UI Elements | 6-digit PIN input (PinCodeTextField), confirm button, back navigation |
| Constructor Param | `email: String` (required) - Email to verify |

---

#### OTPSuccessScreen

**File:** [`lib/features/auth/ui/otp_scuccess_screen.dart`](lib/features/auth/ui/otp_scuccess_screen.dart)

| Property | Value |
|----------|-------|
| Class | `OTPSuccessScreen` |
| Route | `/otpSuccess` (Routes.otpSuccessScreen) |
| Cubit Used | None |
| Key UI Elements | Success checkmark icon, congratulations message, continue button |

---

### Models

#### LoginRequestBody

**File:** [`lib/features/auth/data/models/login_request_body.dart`](lib/features/auth/data/models/login_request_body.dart)

| Field | Type | Required |
|-------|------|----------|
| `email` | `String` | Yes |
| `password` | `String` | Yes |

**Constructor:**
```dart
LoginRequestBody({required this.email, required this.password})
```

**fromJson / toJson:**
```dart
factory LoginRequestBody.fromJson(Map<String, dynamic> json)
Map<String, dynamic> toJson() => {'email': email, 'password': password};
```

---

#### LoginResponse

**File:** [`lib/features/auth/data/models/login_response.dart`](lib/features/auth/data/models/login_response.dart)

| Field | Type | Required |
|-------|------|----------|
| `accessToken` | `String` | Yes |
| `expiresAtUtc` | `String` | Yes |
| `refreshToken` | `String` | Yes |

**Constructor:**
```dart
LoginResponse({
  required this.accessToken,
  required this.expiresAtUtc,
  required this.refreshToken,
})
```

**fromJson / toJson:**
```dart
factory LoginResponse.fromJson(Map<String, dynamic> json)
Map<String, dynamic> toJson()
```

---

#### RegisterRequestBody

**File:** [`lib/features/auth/data/models/register_request_body.dart`](lib/features/auth/data/models/register_request_body.dart)

| Field | Type | Required |
|-------|------|----------|
| `email` | `String` | Yes |
| `password` | `String` | Yes |
| `firstName` | `String` | Yes |
| `lastName` | `String` | Yes |

**Constructor:**
```dart
RegisterRequestBody({
  required this.email,
  required this.password,
  required this.firstName,
  required this.lastName,
})
```

**fromJson / toJson:**
```dart
factory RegisterRequestBody.fromJson(Map<String, dynamic> json)
Map<String, dynamic> toJson()
```

---

#### RegisterResponse

**File:** [`lib/features/auth/data/models/register_response.dart`](lib/features/auth/data/models/register_response.dart)

| Field | Type | Required |
|-------|------|----------|
| `message` | `String` | Yes |

**Constructor:**
```dart
RegisterResponse({required this.message})
```

**fromJson / toJson:**
```dart
factory RegisterResponse.fromJson(Map<String, dynamic> json)
Map<String, String> toJson()
```

---

#### VerifyEmailRequestBody

**File:** [`lib/features/auth/data/models/verify_email_request_body.dart`](lib/features/auth/data/models/verify_email_request_body.dart)

| Field | Type | Required |
|-------|------|----------|
| `email` | `String` | Yes |
| `otp` | `String` | Yes |

**Constructor:**
```dart
VerifyEmailRequestBody({
  required this.email,
  required this.otp,
})
```

**fromJson / toJson:**
```dart
factory VerifyEmailRequestBody.fromJson(Map<String, dynamic> json)
Map<String, dynamic> toJson()
```

---

#### OtpErrorModel

**File:** [`lib/features/auth/data/models/otp_error_model.dart`](lib/features/auth/data/models/otp_error_model.dart)

| Field | Type | Required |
|-------|------|----------|
| `statusCode` | `int` | Yes |
| `message` | `String` | Yes |
| `errors` | `Errors` | Yes |

**Nested Class - Errors:**

| Field | Type | Required |
|-------|------|----------|
| `otp` | `List<String>` | Yes |

**fromJson / toJson:**
```dart
factory OtpErrorModel.fromJson(Map<String, dynamic> json)
factory Errors.fromJson(Map<String, dynamic> json)
Map<String, dynamic> toJson()
```

---

### Repositories & Data Sources

#### AuthRepo

**File:** [`lib/features/auth/data/repo/auth_repo.dart`](lib/features/auth/data/repo/auth_repo.dart)

| Interface | Implementation |
|-----------|----------------|
| N/A (concrete class) | - |

**Dependencies:**
- `AuthService` (core service - Dio API calls)
- `FirebaseServices` (Firebase Auth)

**Methods:**

| Method | Parameters | Return Type | Backend |
|--------|------------|-------------|---------|
| `login` | `LoginRequestBody body` | `Future<ApiResult<LoginResponse>>` | Dio (API) |
| `register` | `RegisterRequestBody body` | `Future<ApiResult<RegisterResponse>>` | Dio (API) |
| `verifyEmail` | `VerifyEmailRequestBody body` | `Future<Either<OtpErrorModel, String>>` | Dio (API) |
| `signInWithGoogle` | none | `Future<UserCredential>` | Firebase Auth |
| `signOut` | none | `Future<void>` | Firebase Auth |

---

### Feature-Specific Widgets

#### CustomButton

**File:** [`lib/features/auth/ui/widgets/custom_button.dart`](lib/features/auth/ui/widgets/custom_button.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `text` | `String` | Yes | - |
| `onPressed` | `void Function()?` | No | null |
| `isLoading` | `bool?` | No | null |

**Usage:**
```dart
CustomButton(
  text: 'Login',
  isLoading: false,
  onPressed: () { /* handler */ },
)
```

---

#### CustomLoginMethod

**File:** [`lib/features/auth/ui/widgets/custom_login_method.dart`](lib/features/auth/ui/widgets/custom_login_method.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `iconPath` | `String` | Yes | - |
| `title` | `String` | Yes | - |
| `onTap` | `void Function()?` | No | null |

**Usage:**
```dart
CustomLoginMethod(
  iconPath: AppAssets.googleIcon,
  title: 'Google',
  onTap: () { /* handler */ },
)
```

---

#### DontHaveAlreadyHaveAccountWidget

**File:** [`lib/features/auth/ui/widgets/dont_have_already_have_account_widget.dart`](lib/features/auth/ui/widgets/dont_have_already_have_account_widget.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `title` | `String` | Yes | - |
| `subtitle` | `String` | Yes | - |
| `onTap` | `Function()?` | No | null |

**Usage:**
```dart
DontHaveAlreadyHaveAccountWidget(
  title: "Don't have an account?",
  subtitle: "Sign Up",
  onTap: () { /* navigate */ },
)
```

---

#### LoginBlocListener

**File:** [`lib/features/auth/ui/widgets/login_bloc_listener.dart`](lib/features/auth/ui/widgets/login_bloc_listener.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `email` | `String` | Yes | - |
| `userName` | `String?` | No | null |

**Usage:**
```dart
LoginBlocListener(email: emailController.text)
```

---

#### LoginForm

**File:** [`lib/features/auth/ui/widgets/login_form.dart`](lib/features/auth/ui/widgets/login_form.dart)

A complete form widget containing:
- Email text field with validation
- Password text field with visibility toggle
- Remember me checkbox
- Forgot password link
- Login button with loading state
- LoginBlocListener for state handling

---

#### LoginLogoAndAppName

**File:** [`lib/features/auth/ui/widgets/login_logo_and_app_name.dart`](lib/features/auth/ui/widgets/login_logo_and_app_name.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `title` | `String?` | No | 'EmoVision' |

**Usage:**
```dart
LoginLogoAndAppName(title: 'EmoVision')
```

---

#### OrLoginWith

**File:** [`lib/features/auth/ui/widgets/or_login_with_widget.dart`](lib/features/auth/ui/widgets/or_login_with_widget.dart)

Divider widget with "Or login with" text in the middle. No parameters required.

---

#### OtpBlocListener

**File:** [`lib/features/auth/ui/widgets/otp_bloc_listener.dart`](lib/features/auth/ui/widgets/otp_bloc_listener.dart)

Listens to `OtpCubit` states and handles:
- `OtpError` - Shows error dialog
- `OtpSuccess` - Navigates to success screen

**Usage:**
```dart
const OtpBlocListener()
```

---

#### PhoneTextField

**File:** [`lib/features/auth/ui/widgets/phone_text_field.dart`](lib/features/auth/ui/widgets/phone_text_field.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `onChanged` | `void Function(PhoneNumber)?` | No | null |
| `validator` | `FutureOr<String?> Function(PhoneNumber?)?` | No | null |
| `controller` | `TextEditingController` | Yes | - |

**Usage:**
```dart
PhoneTextField(
  controller: phoneController,
  onChanged: (phone) { /* handler */ },
)
```

---

#### RegisterBlocListener

**File:** [`lib/features/auth/ui/widgets/register_bloc_listener.dart`](lib/features/auth/ui/widgets/register_bloc_listener.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `email` | `String?` | No | null |

**Usage:**
```dart
RegisterBlocListener(email: email.text)
```

---

#### RegisterForm

**File:** [`lib/features/auth/ui/widgets/register_form.dart`](lib/features/auth/ui/widgets/register_form.dart)

A complete registration form containing:
- First name and last name fields
- Email field with validation
- Password field with strength validation
- Confirm password field
- Password validation indicator (animated)
- Register button with loading state
- RegisterBlocListener for state handling

---

#### RegisterScreenHeader

**File:** [`lib/features/auth/ui/widgets/register_screen_header.dart`](lib/features/auth/ui/widgets/register_screen_header.dart)

Header with back button, "Register" title, and login link. No parameters required.

---

#### EnhancedWelcomeScreen

**File:** [`lib/features/auth/ui/widgets/welcom_screen.dart`](lib/features/auth/ui/widgets/welcom_screen.dart)

Animated welcome screen with:
- Gradient background
- Animated app icon/logo
- "Welcome to" text animation
- App name "EmoVision" with scale animation
- Tagline "Your Emotion Recognition App"
- Loading indicator
- Auto-navigation to home after 2.6 seconds

---

## Feature: home

### Folder Structure

```
home/
├── data/
│   ├── model/
│   │   └── user_model.dart
│   └── repo/
│       └── home_repo.dart
├── logic/
│   └── cubit/
│       ├── home_cubit.dart
│       └── home_state.dart
└── ui/
    ├── home_screen.dart
    └── widgets/
        ├── analyze_button.dart
        ├── home_header.dart
        ├── video_upload_section.dart
        └── welcome_message.dart
```

### Cubits & States

#### HomeCubit

**File:** [`lib/features/home/logic/cubit/home_cubit.dart`](lib/features/home/logic/cubit/home_cubit.dart)

| State | Class | Description | Trigger |
|-------|-------|-------------|---------|
| Initial | `HomeInitial` | Initial state | Constructor |
| Loading | `HomeLoading` | Loading user info | `getCurrentUserInfo()` called |
| Success | `HomeSuccess` | User info loaded | `getCurrentUserInfo()` succeeds |
| Failure | `HomeFailure` | Error loading user info | `getCurrentUserInfo()` fails |

**Usage Example (BlocBuilder):**

```dart
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if (state is HomeLoading) {
      return CircularProgressIndicator();
    }
    if (state is HomeSuccess) {
      return Text('Welcome ${state.userModel?.name}');
    }
    return SizedBox.shrink();
  },
)
```

---

### Screens / Views

#### HomeScreen

**File:** [`lib/features/home/ui/home_screen.dart`](lib/features/home/ui/home_screen.dart)

| Property | Value |
|----------|-------|
| Class | `HomeScreen` |
| Route | `/home` (Routes.homeScreen) |
| Cubit Used | `HomeCubit` |
| Key UI Elements | HomeHeader, VideoUploadSection, AnalyzeButton |

**Constructor Parameters:**

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `email` | `String?` | No | null |
| `userName` | `String?` | No | null |
| `photoUrl` | `String?` | No | null |

---

### Models

#### UserModel

**File:** [`lib/features/home/data/model/user_model.dart`](lib/features/home/data/model/user_model.dart)

| Field | Type | Required |
|-------|------|----------|
| `uid` | `String` | Yes |
| `name` | `String` | Yes |
| `email` | `String` | Yes |
| `photoURL` | `String` | Yes |
| `provider` | `String` | Yes |
| `createdAt` | `FieldValue` | Yes |

**Constructor:**
```dart
UserModel({
  required this.uid,
  required this.name,
  required this.email,
  required this.photoURL,
  required this.provider,
  required this.createdAt,
})
```

**fromJson / toJson:**
```dart
factory UserModel.fromJson(Map<String, dynamic> map)
Map<String, dynamic> toJson()
```

---

### Repositories & Data Sources

#### HomeRepo

**File:** [`lib/features/home/data/repo/home_repo.dart`](lib/features/home/data/repo/home_repo.dart)

| Interface | Implementation |
|-----------|----------------|
| N/A (concrete class) | - |

**Dependencies:**
- `FirebaseServices` (Firebase Firestore)

**Methods:**

| Method | Parameters | Return Type | Backend |
|--------|------------|-------------|---------|
| `getCurrentUserInfo` | none | `UserModel?` | Firebase Firestore |

---

### Feature-Specific Widgets

#### HomeHeader

**File:** [`lib/features/home/ui/widgets/home_header.dart`](lib/features/home/ui/widgets/home_header.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `photoUrl` | `String?` | No | null |
| `userName` | `String?` | No | null |
| `email` | `String?` | No | null |

**Usage:**
```dart
HomeHeader(
  userName: _userName,
  email: _userEmail,
  photoUrl: _photoUrl,
)
```

---

#### WelcomeMessage

**File:** [`lib/features/home/ui/widgets/welcome_message.dart`](lib/features/home/ui/widgets/welcome_message.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `userEmail` | `String?` | No | null |
| `userName` | `String?` | No | null |
| `isBiometricLogin` | `bool` | No | false |
| `isGoogleLogin` | `bool` | No | false |

**Usage:**
```dart
WelcomeMessage(
  userEmail: _userEmail,
  userName: _userName,
  isBiometricLogin: _isBiometricLogin,
  isGoogleLogin: _isGoogleLogin,
)
```

---

#### VideoUploadSection

**File:** [`lib/features/home/ui/widgets/video_upload_section.dart`](lib/features/home/ui/widgets/video_upload_section.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `onVideoSelected` | `Function(File?)` | Yes | - |

**Usage:**
```dart
VideoUploadSection(onVideoSelected: _onVideoSelected)
```

---

#### AnalyzeButton

**File:** [`lib/features/home/ui/widgets/analyze_button.dart`](lib/features/home/ui/widgets/analyze_button.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `onTap` | `VoidCallback` | Yes | - |

**Usage:**
```dart
AnalyzeButton(onTap: _showAnalysisDialog)
```

---

## Feature: onboarding

### Folder Structure

```
onboarding/
└── ui/
    ├── onboarding_screen.dart
    └── widgets/
        ├── onboarding_buttons.dart
        ├── onboarding_page.dart
        └── smooth_page_indicator_widget.dart
```

### Screens / Views

#### OnboardingScreen

**File:** [`lib/features/onboarding/ui/onboarding_screen.dart`](lib/features/onboarding/ui/onboarding_screen.dart)

| Property | Value |
|----------|-------|
| Class | `OnboardingScreen` |
| Route | `/onboarding` (Routes.onboardingScreen) |
| Cubit Used | None |
| Key UI Elements | PageView with 3 pages, SmoothPageIndicator, OnboardingButtons |

**Pages:**
1. **Secure & Safe** - "Your data is encrypted and protected with industry-leading security standards." (Icon: `Icons.security`, Color: Blue)
2. **Lightning Fast** - "Access your account instantly with our optimized authentication system." (Icon: `Icons.light_mode_outlined`, Color: Cyan)
3. **Easy to Use** - "Simple and intuitive login process designed for everyone." (Icon: `Icons.people`, Color: Purple)

---

### Feature-Specific Widgets

#### OnboardingButtons

**File:** [`lib/features/onboarding/ui/widgets/onboarding_buttons.dart`](lib/features/onboarding/ui/widgets/onboarding_buttons.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `currentPage` | `int` | Yes | - |
| `pageController` | `PageController` | Yes | - |

**Behavior:**
- On last page (index 2): Shows "Get Started" button that navigates to login
- On other pages: Shows "Next" button to advance to next page and "Skip" button

**Usage:**
```dart
OnboardingButtons(
  currentPage: _currentPage,
  pageController: _pageController,
)
```

---

#### OnboardingPage

**File:** [`lib/features/onboarding/ui/widgets/onboarding_page.dart`](lib/features/onboarding/ui/widgets/onboarding_page.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `icon` | `IconData` | Yes | - |
| `title` | `String` | Yes | - |
| `description` | `String` | Yes | - |
| `color` | `Color` | Yes | - |

**Usage:**
```dart
OnboardingPage(
  icon: Icons.security,
  title: 'Secure & Safe',
  description: 'Your data is encrypted...',
  color: Color(0xFF3B82F6),
)
```

---

#### SmoothPageIndicatorWidget

**File:** [`lib/features/onboarding/ui/widgets/smooth_page_indicator_widget.dart`](lib/features/onboarding/ui/widgets/smooth_page_indicator_widget.dart)

| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| `pageController` | `PageController` | Yes | - |
| `currentPage` | `int` | Yes | - |

**Usage:**
```dart
SmoothPageIndicatorWidget(
  pageController: _pageController,
  currentPage: _currentPage,
)
```

---

*Document generated from `lib/features/` directory analysis*
