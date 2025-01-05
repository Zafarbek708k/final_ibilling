import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final List<ContractEntity> contracts;

  const UserEntity({required this.contracts, required this.fullName, required this.id});

  @override
  List<Object?> get props => [id, fullName, contracts];
}

class ContractEntity extends Equatable {
  final String contractId;
  final bool saved;
  final String author;
  final String status;
  final String amount;
  final String lastInvoice;
  final String numberOfInvoice;
  final String addressOrganization;
  final String innOrganization;
  final String dateTime;

  const ContractEntity({
    required this.contractId,
    required this.saved,
    required this.author,
    required this.status,
    required this.amount,
    required this.lastInvoice,
    required this.numberOfInvoice,
    required this.addressOrganization,
    required this.innOrganization,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [
        contractId,
        saved,
        author,
        status,
        amount,
        lastInvoice,
        numberOfInvoice,
        addressOrganization,
        innOrganization,
        dateTime,
      ];
}
