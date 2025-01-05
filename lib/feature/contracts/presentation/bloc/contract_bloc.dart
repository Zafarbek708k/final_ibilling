import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/contract_usecase.dart';

import '../../../../core/singletons/di/service_locator.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractUseCase _homeUseCase = ContractUseCase(repo: sl.call());

  ContractBloc() : super(const ContractState()) {
    on<ContractEvent>((event, emit) {});
    init();
  }

  void init() async {
     state.copyWith(status: ContractStateStatus.loading);

    final result = await _homeUseCase.repo.getAllContractRepo();

    result.fold(
      (failure) {
        state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message);
      },
      (users) {
        final contracts = users.expand((user) => user.contracts as List<ContractModel>).toList();
        log("user count ${users.length} contracts count = ${contracts.length}");
        state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts);
      },
    );
  }
}
