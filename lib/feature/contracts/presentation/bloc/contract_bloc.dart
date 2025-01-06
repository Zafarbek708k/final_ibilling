import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/contract_usecase.dart';

import '../../../../core/singletons/di/service_locator.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractUseCase _homeUseCase = ContractUseCase(repo: sl.call());

  ContractBloc() : super(const ContractState()) {
    on<ContractEvent>((event, emit) {});
    on<GetALlContractEvent>((event, emit) => _getAllContractEvent(event, emit));
    init();
  }

  Future<void> _getAllContractEvent(GetALlContractEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: ContractStateStatus.loading));
    final result = await _homeUseCase.repo.getAllContractRepo();

    result.fold(
      (failure) {
        emit(state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message));
      },
      (users) {
        final contracts = users.expand((user) => user.contracts).toList();
        log("user count ${users.length} contracts count = ${contracts.length}");
        emit(state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts));
      },
    );
  }

  void init() async {
    emit(state.copyWith(status: ContractStateStatus.loading));

    final result = await _homeUseCase.repo.getAllContractRepo();

    result.fold(
      (failure) {
        emit(state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message));
      },
      (users) {
        final contracts = users.expand((user) => user.contracts as List<ContractModel>).toList();
        log("user count ${users.length} contracts count = ${contracts.length}");
        emit(state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts));
      },
    );
  }

  void search(String text){
    final list = state.filteredList;
    final searchList = list.where((contract){
      return contract.author.toString().toLowerCase().contains(text.toLowerCase());
    }).toList();
    emit(state.copyWith(searchList: searchList));
  }

  void clear(){
    emit(state.copyWith(searchList: []));
  }

}
