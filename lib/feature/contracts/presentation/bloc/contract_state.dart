part of 'contract_bloc.dart';

enum ContractStateStatus { initial, loading, loaded, error }

class ContractState extends Equatable {
  final ContractStateStatus status;
  final List<UserEntity> userList;
  final List<ContractEntity> filteredList;
  final List<ContractEntity> searchList;
  final String errorMsg;

  const ContractState({
    this.errorMsg = "",
    this.status = ContractStateStatus.initial,
    this.userList = const [],
    this.filteredList = const [],
    this.searchList = const [],
  });

  ContractState copyWith({
    ContractStateStatus? status,
    String? errorMsg,
    List<UserEntity>? userList,
    List<ContractEntity>? filteredList,
    List<ContractEntity>? searchList,
  }) =>
      ContractState(
        status: status ?? this.status,
        errorMsg: errorMsg??this.errorMsg,
        filteredList: filteredList ?? this.filteredList,
        userList: userList ?? this.userList,
        searchList: searchList ?? this.searchList,
      );

  @override
  List<Object?> get props => [status, userList, filteredList, searchList];
}
