part of 'saved_bloc.dart';

enum SavedStateStatus { init, loading, loaded, error }

class SavedState extends Equatable {
  final List<ContractEntity> contractEntity;
  final List<UserEntity> users;
  final String errorMsg;
  final SavedStateStatus status;

  const SavedState({this.contractEntity = const [], this.users = const [],this.errorMsg = "", this.status = SavedStateStatus.init});

  SavedState copyWith({
    List<ContractEntity>? contractEntity,
    List<UserEntity>? users,
    String? errorMsg,
    SavedStateStatus? status,
  }) =>
      SavedState(
        status: status ?? this.status,
        users: users ?? this.users,
        errorMsg: errorMsg ?? this.errorMsg,
        contractEntity: contractEntity ?? this.contractEntity,
      );

  @override
  List<Object?> get props => [contractEntity, errorMsg, users];
}
