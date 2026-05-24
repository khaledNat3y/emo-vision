# Features Layer Quick Reference Guide

## File Structure Overview

```
lib/features/
├── auth/
│   ├── data/
│   │   └── models/
│   │       ├── login_request_body.dart
│   │       ├── login_response.dart
│   │       ├── register_request_body.dart
│   │       ├── register_response.dart
│   │       ├── forgot_password_request_body.dart
│   │       ├── reset_password_request_body.dart
│   │       └── *.g.dart            # Generated JSON serialization
│   ├── logic/
│   │   ├── login_cubit/
│   │   │   ├── login_cubit.dart    # Email/password + Google auth
│   │   │   └── login_state.dart
│   │   ├── register_cubit/
│   │   ├── forgot_password_cubit/
│   │   └── logout_cubit/
│   └── ui/
│       ├── widgets/
│       │   ├── login_form.dart
│       │   ├── custom_button.dart
│       │   ├── custom_login_method.dart
│       │   ├── otp_pin_field.dart
│       │   ├── phone_text_field.dart
│       │   ├── login_register_screen_header_column.dart
│       │   └── login_bloc_listener.dart
│       ├── login_screen.dart
│       ├── login_screen_body.dart
│       ├── register_screen.dart
│       ├── register_screen_body.dart
│       ├── forgot_password_screen.dart
│       └── reset_password_screen.dart
├── home/
│   ├── data/
│   │   ├── repo/
│   │   │   └── home_repo.dart
│   │   └── model/
│   │       ├── user_model.dart
│   │       ├── upload_video_request_body.dart
│   │       ├── upload_video_response_model.dart
│   │       └── upload_video_response_error_model.dart
│   ├── logic/
│   │   └── cubit/
│   │       ├── home_cubit.dart       # User info loading
│   │       ├── home_state.dart
│   │       ├── upload_video_cubit.dart # Video analysis
│   │       └── upload_video_state.dart
│   └── ui/
│       ├── widgets/
│       │   ├── home_body.dart
│       │   ├── home_header.dart
│       │   ├── home_welcome_card.dart
│       │   ├── home_analyze_section.dart
│       │   ├── video_upload_section.dart
│       │   ├── analyze_button.dart
│       │   └── home_result_card.dart
│       └── home_screen.dart
└── onboarding/
    └── ui/
        ├── widgets/
        │   ├── onboarding_page.dart
        │   ├── onboarding_buttons.dart
        │   └── smooth_page_indicator_widget.dart
        └── onboarding_screen.dart
```

---

## Auth Feature

### Login Flow

**File:** `lib/features/auth/logic/login_cubit/login_cubit.dart`

```dart
class LoginCubit extends Cubit<LoginState> {
  Future<void> login({required String email, required String password})
  Future<void> signInWithGoogle()
  Future<void> signOut()
}
```

**States:**
- `LoginInitial` - Initial state
- `LoginLoading` - Processing login
- `LoginSuccess` - Email login success
- `LoginWithGoogleLoading` - Processing Google sign-in
- `LoginWithGoogleSuccess` - Google sign-in success
- `LoginError` - Error occurred

**Usage Example:**
```dart
// In UI
BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    final isLoading = state is LoginLoading;
    return CustomButton(
      text: 'Sign In',
      isLoading: isLoading,
      onPressed: () => context.read<LoginCubit>().login(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  },
)
```

### Widgets

#### LoginForm (`lib/features/auth/ui/widgets/login_form.dart`)
```dart
LoginForm()  // Self-contained with email/password fields
```

#### CustomButton (`lib/features/auth/ui/widgets/custom_button.dart`)
```dart
CustomButton(
  text: 'Continue',
  isLoading: false,
  onPressed: () {},
  radius: 50,  // Optional, default 50
  color: AppColors.primary,  // Optional
)
```

#### CustomLoginMethod (`lib/features/auth/ui/widgets/custom_login_method.dart`)
```dart
CustomLoginMethod(
  iconPath: AppAssets.googleIcon,
  title: 'Google',
  onTap: () => context.read<LoginCubit>().signInWithGoogle(),
)
```

### LoginBlocListener (`lib/features/auth/ui/widgets/login_bloc_listener.dart`)
Handles navigation based on auth state:
- `LoginSuccess` → Navigate to home
- `LoginWithGoogleSuccess` → Navigate to home with Google data

---

## Home Feature

### Home Cubit (`lib/features/home/logic/cubit/home_cubit.dart`)

```dart
class HomeCubit extends Cubit<HomeState> {
  Future<void> loadUserInfo({
    String? emailFromArgs,
    String? userNameFromArgs,
    String? photoUrlFromArgs,
    String? loginMethod,
  })
}
```

**States:**
- `HomeInitial` - Initial state
- `HomeLoading` - Loading user info
- `HomeSuccess` - Contains email, userName, photoUrl, isBiometric
- `HomeFailure` - Error loading info

### UploadVideo Cubit (`lib/features/home/logic/cubit/upload_video_cubit.dart`)

```dart
class UploadVideoCubit extends Cubit<UploadVideoState> {
  Future<void> uploadVideo(File videoFile)
}
```

**States:**
- `UploadVideoInitial` - Ready
- `UploadVideoLoading` - Processing
- `UploadVideoSuccess` - Contains UploadVideoResponseModel
- `UploadVideoError` - Contains error model

### Widgets

#### HomeBody (`lib/features/home/ui/widgets/home_body.dart`)
```dart
HomeBody(
  state: homeState,
  scrollController: scrollController,
  resultKey: resultKey,
  onLogoutTap: () => _showLogoutDialog(context),
)
```

#### HomeHeader (`lib/features/home/ui/widgets/home_header.dart`)
Displays user avatar, name, and logout button.

#### HomeWelcomeCard (`lib/features/home/ui/widgets/home_welcome_card.dart`)
Gradient welcome banner showing:
- "Welcome back 👋"
- User name
- Login method badge (Biometric/Email/Google)

#### HomeAnalyzeSection (`lib/features/home/ui/widgets/home_analyze_section.dart`)
Contains:
- Section title
- VideoUploadSection
- AnalyzeButton
- HomeResultCard (when analysis complete)

#### VideoUploadSection (`lib/features/home/ui/widgets/video_upload_section.dart`)
Wraps VideoUploadWidget with callbacks.

#### AnalyzeButton (`lib/features/home/ui/widgets/analyze_button.dart`)
Gradient button with:
- Play icon
- "Analyze Video" text
- AI-powered subtitle
- Loading state

#### HomeResultCard (`lib/features/home/ui/widgets/home_result_card.dart`)
Displays analysis results:
- Prediction label (Engaged/Not Engaged)
- Frame count
- Color-coded based on result

---

## Onboarding Feature

### OnboardingScreen (`lib/features/onboarding/ui/onboarding_screen.dart`)
```dart
OnboardingScreen(
  // 3 pages with PageView
  // Indicators at bottom
  // Skip/Next/Done buttons
)
```

### OnboardingPage (`lib/features/onboarding/ui/widgets/onboarding_page.dart`)
```dart
OnboardingPage(
  icon: Icons.security,
  title: 'Secure & Safe',
  description: 'Your data is encrypted...',
  color: Color(0xFF3B82F6),
)
```

### SmoothPageIndicatorWidget
Dots indicator showing current page.

---

## Data Models

### UploadVideoResponseModel
```dart
class UploadVideoResponseModel {
  final String? prediction;       // "engaged" or "not engaged"
  final Metadata? metadata;
}

class Metadata {
  final int? totalFrames;
}
```

### Login/Register Response Models
Uses Supabase user metadata:
- `email`
- `userMetadata['full_name']`
- `userMetadata['avatar_url']`

---

## State Management Patterns

### Cubit Pattern
```dart
// Creating
class MyCubit extends Cubit<MyState> {
  MyCubit() : super(const Initial());
  
  Future<void> doSomething() async {
    emit(const Loading());
    try {
      // Do work
      emit(Success(data: result));
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}

// Reading in UI
BlocBuilder<MyCubit, MyState>(
  builder: (context, state) {
    if (state is Loading) return const CircularProgressIndicator();
    if (state is Success) return Text(state.data);
    return const SizedBox.shrink();
  },
)

// Dispatching
context.read<MyCubit>().doSomething();
```

### Dependency Injection
```dart
// Register in getIt
GetIt.I.registerLazySingleton(() => LoginCubit(GetIt.I<SupabaseAuthService>()));

// Create in route
BlocProvider(
  create: (_) => getIt<LoginCubit>(),
  child: LoginScreen(),
)
```

---

## Navigation Flow

```
OnboardingScreen
    ↓ (if not seen)
LoginScreen
    ├── Email/Password → HomeScreen
    ├── Google → HomeScreen (with photoUrl)
    └── Biometric → HomeScreen (isBiometric=true)

HomeScreen
    ├── Analyze Video → Upload → Result
    └── Logout → LoginScreen
```

---

## Common BLoC Listeners

### LoginBlocListener
```dart
BlocListener<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) {
      context.pushNamed(Routes.homeScreen, arguments: {
        'email': state.email,
        'userName': state.userName,
      });
    }
  },
)
```

### UploadVideo Listener
```dart
BlocListener<UploadVideoCubit, UploadVideoState>(
  listener: (context, state) {
    if (state is UploadVideoSuccess) {
      _scrollToResult();
    }
    if (state is UploadVideoError) {
      ScaffoldMessenger.of(context).showSnackBar(...);
    }
  },
)
```