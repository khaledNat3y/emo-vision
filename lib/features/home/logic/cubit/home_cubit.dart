import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/user_model.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());


  Future<void> getCurrentUserInfo() async {
  emit(HomeLoading());
  try {
    final UserModel? userInfo = homeRepo.getCurrentUserInfo();
    emit(HomeSuccess(userInfo));
  } catch (e) {
    emit(HomeFailure(e.toString()));
  }
}
}
