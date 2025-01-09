part of 'saved_bloc.dart';

sealed class SavedEvent extends Equatable {
  const SavedEvent();
}

class Save extends SavedEvent {
  final ContractEntity contract;

  const Save({required this.contract});

  @override
  List<Object?> get props => [contract];
}

class UnSave extends SavedEvent {
  final ContractEntity contract;

  const UnSave({required this.contract});

  @override
  List<Object?> get props => [contract];
}

class Delete extends SavedEvent {
  final ContractEntity contract;
  final BuildContext context;

  const Delete({required this.contract, required this.context});

  @override
  List<Object?> get props => [];
}
