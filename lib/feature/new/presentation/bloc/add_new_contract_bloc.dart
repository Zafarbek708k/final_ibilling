import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_new_contract_event.dart';
part 'add_new_contract_state.dart';

class AddNewContractBloc extends Bloc<AddNewContractEvent, AddNewContractState> {
  AddNewContractBloc() : super(AddNewContractInitial()) {
    on<AddNewContractEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
