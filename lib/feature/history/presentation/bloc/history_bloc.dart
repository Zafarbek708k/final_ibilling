import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:final_ibilling/core/usecases/usecase.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/history/domain/usecases/history_usecase.dart';

import '../../../../core/singletons/di/service_locator.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase = HistoryUseCase(repository: sl.call());

  HistoryBloc() : super(const HistoryState()) {
    on<HistoryEvent>((event, emit) {});
    on<StartTimeEvent>((event, emit) => _startTimeEvent(event, emit));
    on<EndTimeEvent>((event, emit) => _endTimeEvent(event, emit));

    init();
  }

  Future<void> _filterEvent() async {
    emit(state.copyWith(status: HistoryStateStatus.loading));
    final list = state.contracts;
    final startTime = state.startTime;
    final endTime = state.endTime;
    final dateFormat = DateFormat("HH:mm, d MMMM, yyyy");

    log("start time = $startTime  \n endTime = $endTime \n list count = ${list.length} state list count => ${state.contracts.length}");

    // Filter the contracts based on the provided logic
    final filteredList = list.where((contract) {
      final contractDateTime = dateFormat.parse(contract.dateTime);

      log("parse Date Time => $contractDateTime");

      // Skip if contractDateTime is null
      if (contractDateTime == null) return false;

      // Case 1: Both startTime and endTime are not null
      if (startTime != null && endTime != null) {
        log("message");
        return contractDateTime.isAfter(endTime) && contractDateTime.isBefore(startTime);
      }

      // Case 2: Only startTime is not null
      if (startTime != null && endTime == null) {
        return contractDateTime.isAfter(startTime);
      }

      // Case 3: Only endTime is not null
      if (startTime == null && endTime != null) {
        return contractDateTime.isBefore(endTime);
      }

      // Case 4: Both startTime and endTime are null
      return true; // Include all contracts
    }).toList();

    log("Filtered list count = ${filteredList.length}");
    emit(state.copyWith(filteredList: filteredList, status: HistoryStateStatus.loaded));
  }


  Future<void> _startTimeEvent (StartTimeEvent event, Emitter<HistoryState>emit)async{
    emit(state.copyWith(startTime: event.startTime));
    _filterEvent();
  }
  Future<void> _endTimeEvent (EndTimeEvent event, Emitter<HistoryState>emit)async{
    emit(state.copyWith(endTime: event.endTime));
    _filterEvent();
  }



  Future<void> init() async {
    emit(state.copyWith(status: HistoryStateStatus.loading, endTime: null, startTime: null));
    // NoParams params = NoParams();
    final resul = await _historyUseCase.call(NoParams());
    resul.fold(
      (failure) {
        emit(state.copyWith(status: HistoryStateStatus.error, errorMsg: failure.message));
      },
      (allData) {
        final contracts = allData.expand((user) => user.contracts).toList();
        emit(state.copyWith(status: HistoryStateStatus.loaded, contracts: contracts));
      },
    );
  }
}
