import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/contract_usecase.dart';

import '../../../../core/singletons/di/service_locator.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractUseCase _homeUseCase = ContractUseCase(repo: sl.call());

  ContractBloc() : super(ContractState()) {
    on<ContractEvent>((event, emit) {});
    on<GetALlContractEvent>((event, emit) => _getAllContractEvent(event, emit));
    on<ContractFilterEvent>((event, emit) => _contractFilterEvent(event, emit));
    on<BeginDateSelectEvent>((event, emit) => beginDateSelect(event, emit));
    on<EndDateSelectEvent>((event, emit) => endDateSelect(event, emit));
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
        emit(state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts, fullContract: contracts));
      },
    );
  }

  void _contractFilterEvent(ContractFilterEvent event, Emitter<ContractState> emit) {
    final DateFormat inputFormat = DateFormat("HH:mm, d MMMM, yyyy");
    final List<ContractEntity> originalList = state.fullContract;
    log("original list count = ${originalList.length}");
    emit(state.copyWith(status: ContractStateStatus.loading));

    try {
      List<ContractEntity> filteredByStatus = originalList.where((item) {
        return (event.paid && item.status == 'paid') ||
            (event.process && item.status == 'inProgress') ||
            (event.rejectIq && item.status == 'rejectByIQ') ||
            (event.rejectPay && item.status == 'rejectByPayme');
      }).toList();

      log("filtered by status list Length => ${filteredByStatus.length}");

      // Filter by date
      List<ContractEntity> finalFilteredList = filteredByStatus.where((item) {
        try {
          if (item.dateTime == null) return false;
          DateTime itemDateTime = inputFormat.parse(item.dateTime);
          return itemDateTime.isAfter(state.beginDate) && itemDateTime.isBefore(state.endDate);
        } catch (e) {
          log("Date parse error for item: ${item.author}, error: $e");
          return false;
        }
      }).toList();

      log("Filtered list count: ${finalFilteredList.length}, Original list count: ${originalList.length}");

      // Emit updated state
      emit(
        state.copyWith(
            status: ContractStateStatus.loaded,
            filteredList: finalFilteredList,
            paid: event.paid,
            inProcess: event.process,
            rejectByIQ: event.rejectIq,
            rejectByPayme: event.rejectPay),
      );

      log("state filter list count => ${state.filteredList.length}");
    } catch (e) {
      emit(state.copyWith(status: ContractStateStatus.error, errorMsg: "Failed to filter contracts. Error: $e"));
    }
  }

  void beginDateSelect(BeginDateSelectEvent event, Emitter<ContractState> emit) {
    emit(state.copyWith(beginDate: event.beginTime));
  }

  void endDateSelect(EndDateSelectEvent event, Emitter<ContractState> emit) {
    emit(state.copyWith(endDate: event.endTime));
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
        emit(state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts, fullContract: contracts));
      },
    );
  }

  void search(String text) {
    final list = state.filteredList;
    final searchList = list.where((contract) {
      return contract.author.toString().toLowerCase().contains(text.toLowerCase());
    }).toList();
    emit(state.copyWith(searchList: searchList));
  }

  void clear() {
    emit(state.copyWith(searchList: []));
  }
}
