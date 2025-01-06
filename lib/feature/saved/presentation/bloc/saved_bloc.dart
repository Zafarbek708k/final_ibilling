import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/saved/domain/usecases/saved_usecase.dart';
import '../../../../core/singletons/di/service_locator.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedUseCase savedUseCase = SavedUseCase(repository: sl.call());

  SavedBloc() : super(const SavedState()) {
    on<SavedEvent>((event, emit) {});
    loadData();
  }

  void loadData() async {
    emit(state.copyWith(status: SavedStateStatus.loading));
    final result = await savedUseCase.repository.getSavedContract();
    result.fold(
      (failure) {
        emit(state.copyWith(status: SavedStateStatus.error, errorMsg: failure.message));
      },
      (savedContracts) {
        log("saved contract list length = ${savedContracts.length}");
        emit(state.copyWith(status: SavedStateStatus.loaded, contractEntity: savedContracts));
      },
    );
  }
}
