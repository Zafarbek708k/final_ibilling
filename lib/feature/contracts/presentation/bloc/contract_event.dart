part of 'contract_bloc.dart';

sealed class ContractEvent extends Equatable {
  const ContractEvent();
}

class ReloadEvent extends ContractEvent {
  @override
  List<Object?> get props => [];
}

class SelectOneDayEvent extends ContractEvent {
  final DateTime date;

  const SelectOneDayEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

class SearchEvent extends ContractEvent {
  final String text;

  const SearchEvent({required this.text});

  @override
  List<Object?> get props => [];
}

class GetALlContractEvent extends ContractEvent {
  @override
  List<Object?> get props => [];
}

class ContractFilterEvent extends ContractEvent {
  final bool paid, process, rejectIq, rejectPay;
  final DateTime start, end;

  const ContractFilterEvent(
      {required this.paid, required this.process, required this.rejectIq, required this.rejectPay, required this.start, required this.end});

  @override
  List<Object?> get props => [];
}

class BeginDateSelectEvent extends ContractEvent {
  final DateTime beginTime;

  const BeginDateSelectEvent({required this.beginTime});

  @override
  List<Object?> get props => [beginTime];
}

class EndDateSelectEvent extends ContractEvent {
  final DateTime endTime;

  const EndDateSelectEvent({required this.endTime});

  @override
  List<Object?> get props => [endTime];
}

class DeleteContractEvent extends ContractEvent {
  final ContractEntity contract;

  const DeleteContractEvent({required this.contract});

  @override
  List<Object?> get props => [];
}
