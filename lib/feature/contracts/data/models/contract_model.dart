import 'dart:convert';

import '../../domain/entities/contract_entity.dart';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));
List<ContractModel> contractModelFromJson(String str) => List<ContractModel>.from(json.decode(str).map((x) => ContractModel.fromJson(x)));
String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends UserEntity {
  const UserModel({required super.contracts, required super.fullName, required super.id});

  UserModel copyWith({
    String? id,
    String? fullName,
    List<ContractModel>? contracts,
  }) =>
      UserModel(
        contracts: contracts ?? this.contracts,
        fullName: fullName ?? this.fullName,
        id: id ?? this.id,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        contracts: List<ContractModel>.from(json["contracts"].map((x) => ContractModel.fromJson(x))),
        fullName: json["fullName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "contracts": contracts.map((x) => (x as ContractModel).toJson()).toList(),
    };
  }

}

class ContractModel extends ContractEntity {
  const ContractModel({
    required super.contractId,
    required super.saved,
    required super.author,
    required super.status,
    required super.amount,
    required super.lastInvoice,
    required super.numberOfInvoice,
    required super.addressOrganization,
    required super.innOrganization,
    required super.dateTime,
  });

  ContractModel copyWith({
    String? contractId,
    bool? saved,
    String? author,
    String? status,
    String? amount,
    String? lastInvoice,
    String? numberOfInvoice,
    String? addressOrganization,
    String? innOrganization,
    String? dateTime,
  }) =>
      ContractModel(
        contractId: contractId ?? this.contractId,
        saved: saved ?? this.saved,
        author: author ?? this.author,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        lastInvoice: lastInvoice ?? this.lastInvoice,
        numberOfInvoice: numberOfInvoice ?? this.numberOfInvoice,
        addressOrganization: addressOrganization ?? this.addressOrganization,
        innOrganization: innOrganization ?? this.innOrganization,
        dateTime: dateTime ?? this.dateTime,
      );

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
        contractId: json["contractId"],
        saved: json["saved"],
        author: json["author"],
        status: json["status"],
        amount: json["amount"],
        lastInvoice: json["lastInvoice"],
        numberOfInvoice: json["numberOfInvoice"],
        addressOrganization: json["addressOrganization"],
        innOrganization: json["INNOrganization"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "contractId": contractId,
        "saved": saved,
        "author": author,
        "status": status,
        "amount": amount,
        "lastInvoice": lastInvoice,
        "numberOfInvoice": numberOfInvoice,
        "addressOrganization": addressOrganization,
        "INNOrganization": innOrganization,
        "dateTime": dateTime,
      };
}
