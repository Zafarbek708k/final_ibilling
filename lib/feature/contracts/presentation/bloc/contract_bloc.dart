import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/contract_usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/delete_contract_usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/usecases/save_contract_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/singletons/di/service_locator.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractUseCase _homeUseCase = ContractUseCase(repo: sl.call());
  final SaveContractUseCase _saveContractUseCase = SaveContractUseCase(repository: sl.call());
  final DeleteContractUseCase _deleteContractUseCase = DeleteContractUseCase(repository: sl.call());

  ContractBloc() : super(ContractState()) {
    on<ContractEvent>((event, emit) {});
    on<GetALlContractEvent>((event, emit) => _getAllContractEvent(event, emit));
    on<ContractFilterEvent>((event, emit) => _contractFilterEvent(event, emit));
    on<BeginDateSelectEvent>((event, emit) => beginDateSelect(event, emit));
    on<EndDateSelectEvent>((event, emit) => endDateSelect(event, emit));
    // on<SaveContractEvent>((event, emit) => _saveContract(event, emit));
    // on<UnSaveContractEvent>((event, emit) => _unSaveContract(event, emit));
    on<DeleteContractEvent>((event, emit) => _deleteContract(event, emit));
    on<SearchEvent>((event, emit) => _searchEvent(event, emit));
    init();
  }

  Future<void> _searchEvent(SearchEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: ContractStateStatus.loading));

    final fullList = state.fullContract;

    if (event.text == null || event.text.trim().isEmpty) {
      emit(state.copyWith(status: ContractStateStatus.loaded, searchList: fullList));
      return;
    }
    final searchText = event.text.trim().toLowerCase();
    final searchList = fullList.where((contract) {
      return contract.author.toLowerCase().contains(searchText);
    }).toList();
    emit(state.copyWith(status: ContractStateStatus.loaded, searchList: searchList));
  }

  Future<void> _deleteContract(DeleteContractEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: ContractStateStatus.loading));
    final user = state.user;
    user.contracts.removeWhere((contracts) {
      return contracts.contractId == event.contract.contractId;
    });
    final result = await _deleteContractUseCase.call(UserModel(contracts: user.contracts, fullName: user.fullName, id: user.id));
    result.fold(
      (failure) {
        emit(state.copyWith(status: ContractStateStatus.error, errorMsg: "Something went wrong"));
      },
      (nothing) {
        init();
      },
    );
  }

  // Future<void> _unSaveContract(UnSaveContractEvent event, Emitter<ContractState> emit) async {
  //   log("unSave func bloc");
  //   emit(state.copyWith(status: ContractStateStatus.loading));
  //   final user = state.user;
  //   debugPrint("state user contract length  => ${state.user.contracts.length}");
  //   user.contracts.removeWhere((contracts) {
  //     return contracts.contractId == event.contract.contractId;
  //   });
  //   debugPrint("state user contract length after deleting => ${state.user.contracts.length}");
  //   final contract = ContractModel(
  //     contractId: event.contract.contractId,
  //     saved: false,
  //     author: event.contract.author,
  //     status: event.contract.status,
  //     amount: event.contract.amount,
  //     lastInvoice: event.contract.lastInvoice,
  //     numberOfInvoice: event.contract.numberOfInvoice,
  //     addressOrganization: event.contract.addressOrganization,
  //     innOrganization: event.contract.innOrganization,
  //     dateTime: event.contract.dateTime,
  //   );
  //   debugPrint("state user contract length after adding => ${state.user.contracts.length}");
  //   user.contracts.add(contract);
  //
  //   final result = await _saveContractUseCase.call(UserModel(contracts: user.contracts, fullName: user.fullName, id: user.id));
  //
  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(status: ContractStateStatus.error, errorMsg: "error at Saved Contract func"));
  //     },
  //     (nothing) {
  //       log("success");
  //       emit(state.copyWith(status: ContractStateStatus.loaded, saveStatus: SaveContractStatus.save));
  //     },
  //   );
  //   emit(state.copyWith(saveStatus: SaveContractStatus.save));
  //   event.context.read<SavedBloc>().loadData();
  //   init();
  // }
  //
  // Future<void> _saveContract(SaveContractEvent event, Emitter<ContractState> emit) async {
  //   emit(state.copyWith(status: ContractStateStatus.loading));
  //   final user = state.user;
  //   debugPrint("state user contract length  => ${state.user.contracts.length}");
  //   user.contracts.removeWhere((contracts) {
  //     return contracts.contractId == event.contract.contractId;
  //   });
  //   final contract = ContractModel(
  //     contractId: event.contract.contractId,
  //     saved: true,
  //     author: event.contract.author,
  //     status: event.contract.status,
  //     amount: event.contract.amount,
  //     lastInvoice: event.contract.lastInvoice,
  //     numberOfInvoice: event.contract.numberOfInvoice,
  //     addressOrganization: event.contract.addressOrganization,
  //     innOrganization: event.contract.innOrganization,
  //     dateTime: event.contract.dateTime,
  //   );
  //   debugPrint("state user contract length after adding => ${state.user.contracts.length}");
  //   user.contracts.add(contract);
  //
  //   final result = await _saveContractUseCase.call(UserModel(contracts: user.contracts, fullName: user.fullName, id: user.id));
  //
  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(status: ContractStateStatus.error, errorMsg: "error at Saved Contract func"));
  //     },
  //     (nothing) {
  //       log("success");
  //       emit(state.copyWith(status: ContractStateStatus.loaded));
  //     },
  //   );
  //   init();
  //   emit(state.copyWith(saveStatus: SaveContractStatus.save));
  //   event.context.read<SavedBloc>().loadData();
  // }

  Future<void> _getAllContractEvent(GetALlContractEvent event, Emitter<ContractState> emit) async {
    emit(state.copyWith(status: ContractStateStatus.loading));
    final result = await _homeUseCase.repo.getAllContractRepo();

    result.fold(
      (failure) {
        emit(state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message));
      },
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
          if (item.dateTime == null) return false;
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
            rejectByPayme: event.rejectPay),
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

    final result = await _homeUseCase.repo.getAllContractRepo();

    result.fold(
      (failure) {
        emit(state.copyWith(status: ContractStateStatus.error, errorMsg: failure.message));
      },
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

  void clear() {
    emit(state.copyWith(searchList: []));
  }
}
