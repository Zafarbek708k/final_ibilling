part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class FilterEvent extends HistoryEvent {
  final DateTime startTime;
  final DateTime endTime;

  const FilterEvent({required this.startTime, required this.endTime});

  @override
  List<Object?> get props => [startTime, endTime];
}

class StartTimeEvent extends HistoryEvent {
  final DateTime startTime;

  const StartTimeEvent({required this.startTime});

  @override
  List<Object?> get props => [];
}

class EndTimeEvent extends HistoryEvent {
  final DateTime endTime;

  const EndTimeEvent({required this.endTime});

  @override
  List<Object?> get props => [];
}
