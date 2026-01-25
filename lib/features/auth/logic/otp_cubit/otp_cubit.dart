import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/models/verify_email_request_body.dart';
import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../data/models/otp_error_model.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo authRepo;

  OtpCubit(this.authRepo) : super(OtpInitial());

  Future<void> verifyOTP({required VerifyEmailRequestBody body}) async {
    emit(OtpLoading());
    final result = await authRepo.verifyEmail(body: body);
    result.fold((l) => emit(OtpError(l)), (r) => emit(OtpSuccess()));
  }
}
