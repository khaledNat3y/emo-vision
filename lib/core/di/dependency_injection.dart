import 'package:facial_emotional_detection_graduation_project/core/services/biometric_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/supabase/supabase_auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/thumbnail_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/upload_video_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/cubit/theme_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/logout_cubit/logout_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/forgot_password_cubit/cubit/forgot_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/update_password_cubit/cubit/update_password_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/repo/history_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/repo/upload_video_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/delete_account_cubit/delete_account_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/history_cubit/cubit/history_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/upload_video_cubit/upload_video_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/dio_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/home/logic/home_cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // services
  getIt.registerLazySingleton<SupabaseAuthService>(() => SupabaseAuthService());
  getIt.registerLazySingleton<BiometricService>(() => BiometricService());
  getIt.registerLazySingleton<UploadVideoService>(
    () => UploadVideoService(DioHelper.dio),
  );
  getIt.registerLazySingleton<ThumbnailService>(
    () => ThumbnailService(getIt<SupabaseAuthService>()),
  );
  // repos
  getIt.registerLazySingleton<UploadVideoRepo>(
    () => UploadVideoRepo(
      getIt<UploadVideoService>(),
      getIt<SupabaseAuthService>(),
      getIt<ThumbnailService>(),
    ),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(getIt<SupabaseAuthService>()),
  );
  getIt.registerLazySingleton<HistoryRepo>(
    () => HistoryRepo(getIt<SupabaseAuthService>()),
  );
  // cubits
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt<AuthRepo>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt<AuthRepo>()));
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<AuthRepo>()),
  );
  getIt.registerFactory<UploadVideoCubit>(
    () => UploadVideoCubit(getIt<UploadVideoRepo>()),
  );
  getIt.registerFactory<DeleteAccountCubit>(
    () => DeleteAccountCubit(getIt<AuthRepo>()),
  );
  getIt.registerFactory<UpdatePasswordCubit>(
    () => UpdatePasswordCubit(getIt<SupabaseAuthService>()),
  );
  getIt.registerFactory<HistoryCubit>(() => HistoryCubit(getIt<HistoryRepo>()));
}
