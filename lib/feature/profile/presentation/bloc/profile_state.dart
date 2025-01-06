part of 'profile_bloc.dart';

enum ProfileStateStatus { init, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStateStatus status;
  final String errorMsg;
  final String locale;

  const ProfileState({this.status = ProfileStateStatus.init, this.errorMsg = "", this.locale =""});

  ProfileState copyWith({
    ProfileStateStatus? status,
    String? errorMsg,
    String? locale,
})=> ProfileState(
    locale: locale ?? this.locale,
    status: status ?? this.status,
    errorMsg: errorMsg ?? this.errorMsg,
  );

  @override
  List<Object?> get props => [status, errorMsg, locale];
}
