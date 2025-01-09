part of 'saved_bloc.dart';

enum SavedStateStatus { init, loading, loaded, error}

class SavedState extends Equatable {
  final List<ContractEntity> contracts;
  final List<ContractEntity> savedContracts;
  final List<UserEntity> users;
  final UserEntity user;
  final String errorMsg;
  final SavedStateStatus status;

  const SavedState({
    this.user = const UserEntity(contracts: [], fullName: "", id: ""),
    this.contracts = const [],
    this.users = const [],
    this.savedContracts = const [],
    this.errorMsg = "",
    this.status = SavedStateStatus.init,
  });

  SavedState copyWith({
    List<ContractEntity>? contracts,
    List<UserEntity>? users,
    List<ContractEntity>? savedContracts,
    UserEntity? user,
    String? errorMsg,
    SavedStateStatus? status,
  }) =>
      SavedState(
        user: user ?? this.user,
        status: status ?? this.status,
        users: users ?? this.users,
        savedContracts: savedContracts ?? this.savedContracts,
        errorMsg: errorMsg ?? this.errorMsg,
        contracts: contracts ?? this.contracts,
      );

  @override
  List<Object?> get props => [contracts, errorMsg, users, user, status, savedContracts];
}
