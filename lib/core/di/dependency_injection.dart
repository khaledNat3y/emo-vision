import 'package:get_it/get_it.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/dio_helper.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/biometric_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/firebase_services.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/otp_cubit/otp_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/cubit/home_cubit.dart';

import '../../features/auth/logic/logout_cubit/logout_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AuthService>(() => AuthService(DioHelper.dio));
  getIt.registerLazySingleton<FirebaseServices>(() => FirebaseServices());
  getIt.registerLazySingleton<BiometricService>(() => BiometricService());

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(getIt<AuthService>(), getIt<FirebaseServices>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt<AuthRepo>()));
  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt<AuthRepo>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt<AuthRepo>()));
}
