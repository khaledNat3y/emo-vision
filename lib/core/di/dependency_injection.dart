import 'package:facial_emotional_detection_graduation_project/core/services/biometric_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/upload_video_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/cubit/theme_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/ui/biometric_login_screen.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/repo/upload_video_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/upload_video_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/dio_helper.dart';

import '../../features/home/logic/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<SupabaseAuthService>(() => SupabaseAuthService());
  getIt.registerLazySingleton<BiometricService>(() => BiometricService());
  getIt.registerLazySingleton<UploadVideoService>(
    () => UploadVideoService(DioHelper.dio),
  );

  getIt.registerLazySingleton<UploadVideoRepo>(
    () => UploadVideoRepo(getIt<UploadVideoService>()),
  );

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<SupabaseAuthService>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<SupabaseAuthService>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<LogoutCubit>(
    () => LogoutCubit(getIt<SupabaseAuthService>()),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<SupabaseAuthService>()),
  );
  getIt.registerFactory<UploadVideoCubit>(
    () => UploadVideoCubit(getIt<UploadVideoRepo>()),
  );
}
