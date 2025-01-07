part of 'add_new_contract_bloc.dart';

 class AddNewContractEvent extends Equatable {
   final String status, inn, address;
   final BuildContext context;
   final VoidCallback clear;
  const AddNewContractEvent({required this.status, required this.address, required this.inn, required this.context, required this.clear});

  @override
  List<Object?> get props => [status, inn, address, context, clear];
}
