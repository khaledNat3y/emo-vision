import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/dio_factory.dart';
import 'package:facial_emotional_detection_graduation_project/core/services/auth_service.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupDependencies() {
  _setupAuth();

}

void _setupAuth() {
  getIt.registerSingleton<Dio>(DioFactory().dio);
  getIt.registerSingleton<AuthService>(AuthService(getIt()));
  getIt.registerSingleton<AuthRepo>(AuthRepo(getIt<AuthService>()));
}