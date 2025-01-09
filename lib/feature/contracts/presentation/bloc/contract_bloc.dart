import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/contract_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/singletons/di/service_locator.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractUseCase _homeUseCase = ContractUseCase(repo: sl.call());

  ContractBloc() : super(ContractState()) {
    on<ContractEvent>((event, emit) {});
    on<ReloadEvent>((event, emit) => init());
    on<GetALlContractEvent>((event, emit) => _getAllContractEvent(event, emit));
    on<ContractFilterEvent>((event, emit) => _contractFilterEvent(event, emit));
    on<BeginDateSelectEvent>((event, emit) => beginDateSelect(event, emit));
    on<EndDateSelectEvent>((event, emit) => endDateSelect(event, emit));
    on<SelectOneDayEvent>((event, emit) => _selectOneDayEvent(event, emit));
    on<SearchEvent>((event, emit) => _searchEvent(event, emit));
    init();
  }

  Future<void> _selectOneDayEvent(SelectOneDayEvent event, Emitter<ContractState> emit) async {
    try {
      emit(state.copyWith(status: ContractStateStatus.loading));
      log("select func emit status loading");
      final DateFormat inputFormat = DateFormat("HH:mm, d MMMM, yyyy");
      final selectedDate = DateTime(event.date.year, event.date.month, event.date.day);

      final filteredList = state.fullContract.where((contract) {
        final DateTime contractDate = inputFormat.parse(contract.dateTime);
        final normalizedContractDate = DateTime(contractDate.year, contractDate.month, contractDate.day);
        return normalizedContractDate == selectedDate;
      }).toList();
      log("one day users = ${filteredList.length}");

      emit(state.copyWith(status: ContractStateStatus.loaded, filteredList: filteredList));
      log("select func emit status loaded\n\n\n");
    } catch (e) {
      emit(state.copyWith(status: ContractStateStatus.error, errorMsg: "Ushbu kunga oid contract mavjud emas"));
    }
  }

  Future<void> _searchEvent(SearchEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: ContractStateStatus.loading));
    final fullList = state.fullContract;
    if (event.text.trim().isEmpty) {
      emit(state.copyWith(status: ContractStateStatus.loaded, searchList: fullList));
      return;
    }
    final searchText = event.text.trim().toLowerCase();
    final searchList = fullList.where((contract) => contract.author.toLowerCase().contains(searchText)).toList();
    emit(state.copyWith(status: ContractStateStatus.loaded, searchList: searchList));
  }

  Future<void> _getAllContractEvent(GetALlContractEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: ContractStateStatus.loading));
    final result = await _homeUseCase.call(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message)),
      (users) {
        final contracts = users.expand((user) => user.contracts).toList();
        emit(state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts, fullContract: contracts));
      },
    );
  }

  void _contractFilterEvent(ContractFilterEvent event, Emitter<ContractState> emit) {
    final DateFormat inputFormat = DateFormat("HH:mm, d MMMM, yyyy");
    final List<ContractEntity> originalList = state.fullContract;
    emit(state.copyWith(status: ContractStateStatus.loading));

    try {
      List<ContractEntity> filteredByStatus = originalList.where((item) {
        return (event.paid && item.status == 'paid') ||
            (event.process && item.status == 'inProgress') ||
            (event.rejectIq && item.status == 'rejectByIQ') ||
            (event.rejectPay && item.status == 'rejectByPayme');
      }).toList();
      List<ContractEntity> finalFilteredList = filteredByStatus.where((item) {
        try {
          DateTime itemDateTime = inputFormat.parse(item.dateTime);
          return itemDateTime.isAfter(state.beginDate) && itemDateTime.isBefore(state.endDate);
        } catch (e) {
          return false;
        }
      }).toList();

      // Emit updated state
      emit(
        state.copyWith(
          status: ContractStateStatus.loaded,
          filteredList: finalFilteredList,
          paid: event.paid,
          inProcess: event.process,
          rejectByIQ: event.rejectIq,
          rejectByPayme: event.rejectPay,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ContractStateStatus.error, errorMsg: "Failed to filter contracts. Error: $e"));
    }
  }

  void beginDateSelect(BeginDateSelectEvent event, Emitter<ContractState> emit) {
    emit(state.copyWith(status: ContractStateStatus.loading));
    Timer(const Duration(milliseconds: 200), () {});
    emit(state.copyWith(beginDate: event.beginTime, status: ContractStateStatus.loaded));
  }

  void endDateSelect(EndDateSelectEvent event, Emitter<ContractState> emit) {
    emit(state.copyWith(status: ContractStateStatus.loading));
    Timer(const Duration(milliseconds: 200), () {});
    emit(state.copyWith(endDate: event.endTime, status: ContractStateStatus.loaded));
  }

  void init() async {
    emit(state.copyWith(status: ContractStateStatus.loading));

    final result = await _homeUseCase.call(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message)),
      (users) {
        final contracts = users.expand((user) => user.contracts as List<ContractModel>).toList();
        final dateFormat = DateFormat('HH:mm, d MMMM, yyyy');

        contracts.sort((a, b) {
          final dateA = dateFormat.parse(a.dateTime);
          final dateB = dateFormat.parse(b.dateTime);
          return dateB.compareTo(dateA);
        });

        emit(
          state.copyWith(status: ContractStateStatus.loaded, userList: users, filteredList: contracts, fullContract: contracts, user: users.first),
        );
      },
    );
  }

  void clear() => emit(state.copyWith(searchList: []));
}
