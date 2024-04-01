part of 'profile_page_cubit.dart';

abstract class ProfilePageState extends Equatable {
  const ProfilePageState();
  @override
  List<Object> get props => [];
}

class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoading extends ProfilePageState {}

class ProfilePageLoaded extends ProfilePageState {
  final UsersModel user;
  const ProfilePageLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfilePageError extends ProfilePageState{
  final String message;
  const ProfilePageError({required this.message});

  @override
  List<Object> get props => [message];
}
