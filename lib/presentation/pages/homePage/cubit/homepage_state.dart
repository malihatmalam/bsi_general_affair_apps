part of 'homepage_cubit.dart';

abstract class HomepageState extends Equatable{
  const HomepageState();
  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {
  final HomepagesModel homepage;
  const HomepageLoaded({required this.homepage});

  @override
  List<Object> get props => [homepage];
}

class HomepageError extends HomepageState{
  final String message;
  const HomepageError({required this.message});

  @override
  List<Object> get props => [message];
}
