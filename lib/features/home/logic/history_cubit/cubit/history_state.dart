// lib/features/home/logic/history_cubit/history_state.dart

part of 'history_cubit.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = _Initial;
  const factory HistoryState.loading() = _Loading;
  const factory HistoryState.success(List<VideoAnalysis> videos) = _Success;
  const factory HistoryState.error(String message) = _Error;
}
