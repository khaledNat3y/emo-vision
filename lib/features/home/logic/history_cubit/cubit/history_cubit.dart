// lib/features/home/logic/history_cubit/history_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/video_analysis.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/repo/history_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepo _repo;

  HistoryCubit(this._repo) : super(const HistoryState.initial());

  Future<void> fetchHistory() async {
    emit(const HistoryState.loading());

    final result = await _repo.fetchHistory();

    result.fold(
      (error) => emit(HistoryState.error(error)),
      (videos) => emit(HistoryState.success(videos)),
    );
  }
}
