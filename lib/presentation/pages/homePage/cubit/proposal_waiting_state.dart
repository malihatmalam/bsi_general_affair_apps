part of 'proposal_waiting_cubit.dart';

abstract class ProposalWaitingState extends Equatable{
  const ProposalWaitingState();
  @override
  List<Object> get props => [];
}

class ProposalWaitingInitial extends ProposalWaitingState {}

class ProposalWaitingLoading extends ProposalWaitingState {}

class ProposalWaitingLoaded extends ProposalWaitingState {
  final List<ProposalsModel> proposals;
  const ProposalWaitingLoaded({required this.proposals});

  @override
  List<Object> get props => [proposals];
}

class ProposalWaitingError extends ProposalWaitingState{
  final String message;
  const ProposalWaitingError({required this.message});

  @override
  List<Object> get props => [message];
}