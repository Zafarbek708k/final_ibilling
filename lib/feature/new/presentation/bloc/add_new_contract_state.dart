part of 'add_new_contract_bloc.dart';

sealed class AddNewContractState extends Equatable {
  const AddNewContractState();
}

final class AddNewContractInitial extends AddNewContractState {
  @override
  List<Object> get props => [];
}
