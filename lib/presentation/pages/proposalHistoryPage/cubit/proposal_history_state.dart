part of 'proposal_history_cubit.dart';

@immutable
abstract class ProposalHistoryState extends Equatable{
  const ProposalHistoryState();
  @override
  List<Object> get props => [];
}

class ProposalHistoryInitial extends ProposalHistoryState {}

class ProposalHistoryLoading extends ProposalHistoryState {}

class ProposalHistoryLoaded extends ProposalHistoryState {
  final List<ProposalsModel> proposals;
  const ProposalHistoryLoaded({required this.proposals});

  @override
  List<Object> get props => [proposals];
}

class ProposalHistoryError extends ProposalHistoryState{
  final String message;
  const ProposalHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}