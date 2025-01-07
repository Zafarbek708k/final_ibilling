part of 'contract_bloc.dart';

enum ContractStateStatus { initial, loading, loaded, error }

class ContractState extends Equatable {
  final ContractStateStatus status;
  final List<UserEntity> userList;
  final List<ContractEntity> fullContract;
  final List<ContractEntity> filteredList;
  final List<ContractEntity> searchList;
  final UserEntity user;
  final String errorMsg;
  final DateTime beginDate;
  final DateTime endDate;
  final bool paid, inProcess, rejectByIQ, rejectByPayme;

  ContractState({
    DateTime? beginDate,
    DateTime? endDate,
    this.user = const UserEntity(contracts: [], fullName: "", id: ""),
    this.errorMsg = "",
    this.status = ContractStateStatus.initial,
    this.userList = const [],
    this.filteredList = const [],
    this.fullContract = const [],
    this.searchList = const [],
    this.paid = false,
    this.inProcess = false,
    this.rejectByPayme = false,
    this.rejectByIQ = false,
  })  : beginDate = beginDate ?? DateTime(2024, 1, 1),
        endDate = endDate ?? DateTime(2025, 1, 1);

  ContractState copyWith({
    ContractStateStatus? status,
    String? errorMsg,
    List<UserEntity>? userList,
    List<ContractEntity>? filteredList,
    List<ContractEntity>? searchList,
    List<ContractEntity>? fullContract,
    UserEntity? user,
    bool? paid,
    bool? inProcess,
    bool? rejectByPayme,
    bool? rejectByIQ,
    DateTime? beginDate,
    DateTime? endDate,
  }) =>
      ContractState(
        beginDate: beginDate ?? this.beginDate,
        endDate: endDate ?? this.endDate,
        user: user ?? this.user,
        paid: paid ?? this.paid,
        inProcess: inProcess ?? this.inProcess,
        rejectByIQ: rejectByIQ ?? this.rejectByIQ,
        rejectByPayme: rejectByPayme ?? this.rejectByPayme,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        filteredList: filteredList ?? this.filteredList,
        fullContract: fullContract ?? this.fullContract,
        userList: userList ?? this.userList,
        searchList: searchList ?? this.searchList,
      );

  @override
  List<Object?> get props => [status, userList, filteredList, searchList, paid, inProcess, rejectByPayme, rejectByIQ, fullContract, user];
}
