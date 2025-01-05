part of 'saved_bloc.dart';

sealed class SavedState extends Equatable {
  const SavedState();
}

final class SavedInitial extends SavedState {
  @override
  List<Object> get props => [];
}
