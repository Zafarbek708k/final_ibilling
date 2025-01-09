import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/data/models/contract_model.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/bloc/contract_bloc.dart';
import 'package:final_ibilling/feature/saved/domain/usecases/delete_usecase.dart';
import 'package:final_ibilling/feature/saved/domain/usecases/save_usecase.dart';
import 'package:final_ibilling/feature/saved/domain/usecases/unsave_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/singletons/di/service_locator.dart';
import '../../domain/usecases/get_saved_contracts.dart';

part 'saved_event.dart';

part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final SaveUseCase _savedUseCase = SaveUseCase(repository: sl.call());
  final UnSaveUseCase _unSavedUseCase = UnSaveUseCase(repository: sl.call());
  final DeleteUseCase _deleteUseCase = DeleteUseCase(repository: sl.call());
  final GetSavedContractsUseCase _getSavedContractsUseCase = GetSavedContractsUseCase(repository: sl.call());

  SavedBloc() : super(const SavedState()) {
    on<SavedEvent>((event, emit) {});
    on<Save>((event, emit) => _save(event, emit));
    on<UnSave>((event, emit) => _unSave(event, emit));
    on<Delete>((event, emit) => _delete(event, emit));
    loadData();
  }

  Future<void> _delete(Delete event, Emitter<SavedState> emit) async {
    emit(state.copyWith(status: SavedStateStatus.loading));
    final updatedContracts = List.of(state.user.contracts)..removeWhere((contract) => contract.contractId == event.contract.contractId);
    final updatedUser = UserModel(contracts: updatedContracts, fullName: state.user.fullName, id: state.user.id);
    final result = await _deleteUseCase.call(updatedUser);
    emit(state.copyWith(status: SavedStateStatus.loading));
    result.fold(
      (failure) => emit(state.copyWith(status: SavedStateStatus.error, errorMsg: failure.message)),
      (success) {
        emit(state.copyWith(status: SavedStateStatus.loaded, user: updatedUser));
        loadData();
      },
    );
  }

  Future<void> _save(Save event, Emitter<SavedState> emit) async {
    emit(state.copyWith(status: SavedStateStatus.loading));
    final contracts = state.user.contracts;
    final index = contracts.indexWhere((contract) => contract.contractId == event.contract.contractId);

    if (index != -1) {
      contracts[index] = ContractModel(
        contractId: event.contract.contractId,
        saved: true,
        author: event.contract.author,
        status: event.contract.status,
        amount: event.contract.amount,
        lastInvoice: event.contract.lastInvoice,
        numberOfInvoice: event.contract.numberOfInvoice,
        addressOrganization: event.contract.addressOrganization,
        innOrganization: event.contract.innOrganization,
        dateTime: event.contract.dateTime,
      );
    }
    final user = UserModel(contracts: contracts, fullName: state.user.fullName, id: state.user.id);
    final result = await _savedUseCase.call(user);
    result.fold(
      (failure) => emit(state.copyWith(status: SavedStateStatus.error, errorMsg: failure.message)),
      (nothing) {
        emit(state.copyWith(status: SavedStateStatus.loaded));
        loadData();
      },
    );
  }

  Future<void> _unSave(UnSave event, Emitter<SavedState> emit) async {
    emit(state.copyWith(status: SavedStateStatus.loading));
    final contracts = state.user.contracts;
    final index = contracts.indexWhere((contract) => contract.contractId == event.contract.contractId);

    if (index != -1) {
      contracts[index] = ContractModel(
        contractId: event.contract.contractId,
        saved: false,
        author: event.contract.author,
        status: event.contract.status,
        amount: event.contract.amount,
        lastInvoice: event.contract.lastInvoice,
        numberOfInvoice: event.contract.numberOfInvoice,
        addressOrganization: event.contract.addressOrganization,
        innOrganization: event.contract.innOrganization,
        dateTime: event.contract.dateTime,
      );
    }
    final user = UserModel(contracts: contracts, fullName: state.user.fullName, id: state.user.id);
    final result = await _unSavedUseCase.call(user);
    result.fold(
      (failure) => emit(state.copyWith(status: SavedStateStatus.error, errorMsg: failure.message)),
      (nothing) {
        emit(state.copyWith(status: SavedStateStatus.loaded));
        loadData();
      },
    );
  }

  void loadData() async {
    emit(state.copyWith(status: SavedStateStatus.loading));
    final result = await _getSavedContractsUseCase.call(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedStateStatus.error, errorMsg: failure.message));
      },
      (users) {
        final contracts = users.expand((user) => user.contracts).toList();
        final filterList = contracts.where((contract) => contract.saved == true).toList();
        final user = users.firstWhere((u) => u.fullName == "Zafarbek Karimov");
        emit(state.copyWith(status: SavedStateStatus.loaded, users: users, contracts: contracts, savedContracts: filterList, user: user));
      },
    );
  }
}
