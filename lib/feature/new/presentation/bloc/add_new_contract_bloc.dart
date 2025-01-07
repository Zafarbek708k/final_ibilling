import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/singletons/di/service_locator.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/new/domain/usecases/add_new_contract_usecase.dart';
import 'package:final_ibilling/feature/new/domain/usecases/get_user_data_usecase.dart';
import 'package:flutter/cupertino.dart';

part 'add_new_contract_event.dart';
part 'add_new_contract_state.dart';

class AddNewContractBloc extends Bloc<AddNewContractEvent, AddNewContractState> {
  final  _getUsers = GetUserDataUseCase(repo: sl.call());
  final _updateUser = AddNewContractUseCase(repo: sl.call());

  AddNewContractBloc() : super(const AddNewContractState()) {
    on<AddNewContractEvent>((event, emit) => _createNewContract(event, emit));
    _getUsersData();
  }

  String monthChecker(int day) {
    switch (day) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "January";
    }
  }

  Future<void> _createNewContract(AddNewContractEvent event, Emitter<AddNewContractState> emit) async {
    debugPrint("loading _createNewContract");
    debugPrint("state user contracts length 1 chi => ${state.user.contracts.length}");
    state.copyWith(status: AddNewContractStateStatus.loading);
    String month = monthChecker(DateTime.now().month);
    final userContracts = [...state.user.contracts];
    debugPrint("state user contracts length 2 chi => ${state.user.contracts.length}");

    final oneContract = ContractEntity(
      contractId: "${5 + Random().nextInt(96)}",
      saved: false,
      author: state.user.fullName,
      status: event.status,
      amount: "${20 + Random().nextInt(80)}",
      lastInvoice: "${50 + Random().nextInt(999)}",
      numberOfInvoice: state.user.contracts.first.numberOfInvoice,
      addressOrganization: event.address,
      innOrganization: event.inn,
      dateTime: "12:30, ${DateTime.now().day} $month, ${DateTime.now().year}",
    );
    userContracts.add(oneContract);
    debugPrint("all contracts updated ${userContracts.length}   username ${state.user.fullName}");
    final user  = UserModel(contracts: userContracts, fullName: state.user.fullName, id: state.user.id);

    final result = await _updateUser.call(user);
    result.fold(
      (failure) {
        state.copyWith(status: AddNewContractStateStatus.error, errorMsg: "Something went wrong");
      },
      (nothing) {
        event.clear();
        state.copyWith(status: AddNewContractStateStatus.loaded);
      },
    );
  }

  Future<void> _getUsersData() async {
    state.copyWith(status: AddNewContractStateStatus.loading);
    final result = await _getUsers.call(NoParams());
    result.fold(
      (failure) {
        state.copyWith(status: AddNewContractStateStatus.error, errorMsg: "Something went wrong");
      },
      (user) {
        debugPrint("user name = ${user.fullName}");
        debugPrint("user contracts length = ${user.contracts.length}");
        emit( state.copyWith(status: AddNewContractStateStatus.loaded, user: user));
      },
    );
  }
}
