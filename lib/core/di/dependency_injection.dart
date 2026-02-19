import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/dio_factory.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/firebase_services.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/login_cubit/login_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/otp_cubit/otp_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/logic/register_cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupDependencies() {
  _setupAuth();
}

void _setupAuth() {
  getIt.registerSingleton<Dio>(DioFactory().dio);
  getIt.registerSingleton<AuthService>(AuthService(getIt()));
  getIt.registerSingleton<FirebaseServices>(FirebaseServices());
  getIt.registerSingleton<AuthRepo>(AuthRepo(getIt<AuthService>(), getIt<FirebaseServices>()));
  /// cubits
  getIt.registerFactory(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => RegisterCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => OtpCubit(getIt<AuthRepo>()));
}