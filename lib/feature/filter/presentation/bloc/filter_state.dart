part of 'filter_bloc.dart';

sealed class FilterState extends Equatable {
  const FilterState();
}

final class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}
