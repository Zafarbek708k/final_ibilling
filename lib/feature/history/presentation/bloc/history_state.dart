part of 'history_bloc.dart';

enum HistoryStateStatus { init, loading, loaded, error }

class HistoryState extends Equatable {
  final HistoryStateStatus status;
  final String errorMsg;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<ContractEntity> contracts;
  final List<ContractEntity> filteredList;

  const HistoryState({
    this.status = HistoryStateStatus.init,
    this.errorMsg = "",
    this.startTime,
    this.endTime,
    this.contracts = const [],
    this.filteredList = const [],
  });

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
