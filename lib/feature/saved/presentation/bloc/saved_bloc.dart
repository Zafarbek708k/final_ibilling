import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/saved/domain/usecases/saved_usecase.dart';
import '../../../../core/singletons/di/service_locator.dart';
import '../../domain/usecases/get_saved_contracts.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedUseCase savedUseCase = SavedUseCase(repository: sl.call());
  final GetSavedContractsUseCase _getSavedContractsUseCase = GetSavedContractsUseCase(repository: sl.call());

  SavedBloc() : super(const SavedState()) {
    on<SavedEvent>((event, emit) {});
    loadData();
  }

  void loadData() async {
    emit(state.copyWith(status: SavedStateStatus.loading));
    final result = await _getSavedContractsUseCase.call(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedStateStatus.error, errorMsg: failure.message));
      },
      (users) {
        log("saved contract list length = ${users.length}");
        final contracts = users.expand((user) => user.contracts).toList();

        final filterList = contracts.where((contract){
          return contract.saved == true;
        }).toList();

        emit(state.copyWith(status: SavedStateStatus.loaded, users: users, contractEntity: filterList));
      },
    );
  }
}
