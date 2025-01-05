part of 'contract_bloc.dart';

enum ContractStateStatus { initial, loading, loaded, error }

class ContractState extends Equatable {
  final ContractStateStatus status;
  final List<UserModel> userList;
  final List<ContractModel> filteredList;
  final String errorMsg;

  const ContractState({
    this.errorMsg = "",
    this.status = ContractStateStatus.initial,
    this.userList = const [],
    this.filteredList = const [],
  });

  ContractState copyWith({
    ContractStateStatus? status,
    String? errorMsg,
    List<UserModel>? userList,
    List<ContractModel>? filteredList,
  }) =>
      ContractState(
        status: status ?? this.status,
        errorMsg: errorMsg??this.errorMsg,
        filteredList: filteredList ?? this.filteredList,
        userList: userList ?? this.userList,
      );

  @override
  List<Object?> get props => [status, userList, filteredList];
}
