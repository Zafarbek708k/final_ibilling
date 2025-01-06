part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}
class ChangeLocaleInProfile extends ProfileEvent{
  final String locale;
  final BuildContext context;
  const ChangeLocaleInProfile({required this.locale, required this.context});
  @override
  List<Object?> get props => throw UnimplementedError();
}