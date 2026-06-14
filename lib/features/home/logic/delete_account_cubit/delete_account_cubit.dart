import 'package:facial_emotional_detection_graduation_project/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this._authRepo) : super(DeleteAccountInitial());
  final AuthRepo _authRepo;

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());

    try {
      await _authRepo.deleteAccount();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountError(error: e.toString()));
    }
  }
}
