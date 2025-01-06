part of 'saved_bloc.dart';

enum SavedStateStatus { init, loading, loaded, error }

class SavedState extends Equatable {
  final List<ContractEntity> contractEntity;
  final String errorMsg;
  final SavedStateStatus status;

  const SavedState({this.contractEntity = const [], this.errorMsg = "", this.status = SavedStateStatus.init});

  SavedState copyWith({
    List<ContractEntity>? contractEntity,
    String? errorMsg,
    SavedStateStatus? status,
  }) =>
      SavedState(
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        contractEntity: contractEntity ?? this.contractEntity,
      );

  @override
  List<Object?> get props => [contractEntity, errorMsg];
}
