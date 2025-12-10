import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/api_error_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

import '../../data/models/register_request_body.dart';
import '../../data/models/register_response.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  RegisterCubit(this.authRepo) : super(RegisterInitial());

  Future<void> register({required RegisterRequestBody body}) async {
    emit(RegisterLoading());
    final result = await authRepo.register(body: body);
    result.when(onSuccess: (data) async {
      Logger.success(data.message);
      emit(RegisterSuccess(data));
    }, onError: (error) {
      Logger.error(error.toString());
      emit(RegisterError(error: error,));
    });
  }
}
