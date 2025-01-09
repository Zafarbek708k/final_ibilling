part of 'history_bloc.dart';

enum HistoryStateStatus { init, loading, loaded, error }

class HistoryState extends Equatable {
  final HistoryStateStatus status;
  final String errorMsg;
  final DateTime startTime;
  final DateTime endTime;
  final List<ContractEntity> contracts;
  final List<ContractEntity> filteredList;

  HistoryState({
    this.status = HistoryStateStatus.init,
    this.errorMsg = "",
    DateTime? startTime,
    DateTime? endTime,
    this.contracts = const [],
    this.filteredList = const [],
  })  : startTime = startTime ?? DateTime(2024, 1, 1),
        endTime = endTime ?? DateTime(2025, 1, 1);

  HistoryState copyWith({
    HistoryStateStatus? status,
    String? errorMsg,
    DateTime? startTime,
    DateTime? endTime,
    List<ContractEntity>? contracts,
    List<ContractEntity>? filteredList,
  }) =>
      HistoryState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        contracts: contracts ?? this.contracts,
        filteredList: filteredList ?? this.filteredList,
      );

  @override
  List<Object?> get props => [status, errorMsg, startTime, endTime, contracts, filteredList];
}
