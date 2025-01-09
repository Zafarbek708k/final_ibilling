import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/singletons/di/service_locator.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/core/utils/utils_service.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/new/domain/usecases/add_new_contract_usecase.dart';
import 'package:final_ibilling/feature/new/domain/usecases/get_user_data_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contracts/presentation/bloc/contract_bloc.dart';

part 'add_new_contract_event.dart';
part 'add_new_contract_state.dart';

class AddNewContractBloc extends Bloc<AddNewContractEvent, AddNewContractState> {
  final _getUsers = GetUserDataUseCase(repo: sl.call());
  final _updateUser = AddNewContractUseCase(repo: sl.call());

  AddNewContractBloc() : super(const AddNewContractState()) {
    on<AddNewContractEvent>((event, emit) => _createNewContract(event, emit));
    _getUsersData();
  }

  String monthChecker(int day) => day == 1
      ? "January"
      : day == 2 ? "February" : day == 3 ? "March" : day == 4 ? "April" : day == 5 ? "May" : day == 6 ? "June" : day == 7 ? "July"
      : day == 8 ? "August" : day == 9 ? "September" : day == 10 ? "October" : day == 11 ? "November" : day == 12 ? "December" : "January";

  Future<void> _createNewContract(AddNewContractEvent event, Emitter<AddNewContractState> emit) async {
    debugPrint("_create new contract");

    emit(state.copyWith(status: AddNewContractStateStatus.loading));
    debugPrint("_get userga kirish");
    await _getUsersData();
    debugPrint("_get user tugadi");
    emit(state.copyWith(status: AddNewContractStateStatus.loading));
    String month = monthChecker(DateTime.now().month);
    final userContracts = [...state.user.contracts];
    debugPrint("old contract list length list=> ${userContracts.length}");

    final oneContract = ContractEntity(
      contractId: "${5 + Random().nextInt(96)}",
      saved: false,
      author: state.user.fullName,
      status: event.status,
      amount: "${20 + Random().nextInt(80)}",
      lastInvoice: "${50 + Random().nextInt(999)}",
      numberOfInvoice: "16",
      addressOrganization: event.address,
      innOrganization: event.inn,
      dateTime: "12:30, ${DateTime.now().day} $month, ${DateTime.now().year}",
    );

    userContracts.add(oneContract);

    debugPrint("new contract list length list=> ${userContracts.length}");
    final user = UserModel(contracts: userContracts, fullName: state.user.fullName, id: state.user.id);

    final result = await _updateUser.call(user);
    result.fold(
      (failure) {
        emit(state.copyWith(status: AddNewContractStateStatus.error, errorMsg: "Something went wrong"));
      },
      (nothing) {
        event.clear();
        Utils.fireSnackBar("Successfully created new contract", event.context);
        emit(state.copyWith(status: AddNewContractStateStatus.loaded));
      },
    );

    event.context.read<ContractBloc>().add(const ContractEvent());
  }

  Future<void> _getUsersData() async {
    debugPrint("_get userdata ga kiridi");
    state.copyWith(status: AddNewContractStateStatus.loading);
    final result = await _getUsers.call(NoParams());
    result.fold(
      (failure) {
        state.copyWith(status: AddNewContractStateStatus.error, errorMsg: "Something went wrong");
      },
      (user) {
        debugPrint("\n\nUser contract list in _getUserData func => ${user.contracts.length}\n\n");
        emit(state.copyWith(status: AddNewContractStateStatus.loaded, user: user));
      },
    );
    debugPrint("_get userdata  tugadi");
  }
}
