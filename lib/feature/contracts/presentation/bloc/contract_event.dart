part of 'contract_bloc.dart';

sealed class ContractEvent extends Equatable {
  const ContractEvent();
}

class GetALlContractEvent extends ContractEvent{
  @override
  List<Object?> get props => [];
}