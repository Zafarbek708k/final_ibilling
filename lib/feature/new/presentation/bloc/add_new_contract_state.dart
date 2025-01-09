part of 'add_new_contract_bloc.dart';

enum AddNewContractStateStatus { init, loading, loaded, error, save}

class AddNewContractState extends Equatable {
  final AddNewContractStateStatus status;
  final String errorMsg;
  final UserEntity user;

  const AddNewContractState({
    this.status = AddNewContractStateStatus.init,
    this.errorMsg = "",
    this.user = const UserEntity(contracts: [], fullName: "", id: ""),
  });

  AddNewContractState copyWith({
    AddNewContractStateStatus? status,
    String? errorMsg,
    UserEntity? user,
  }) =>
      AddNewContractState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [status, errorMsg, user];
}
