part of 'proposal_detail_cubit.dart';

abstract class ProposalDetailState extends Equatable {
  const ProposalDetailState();
  @override
  List<Object> get props => [];
}

class ProposalDetailInitial extends ProposalDetailState {}

class ProposalDetailLoading extends ProposalDetailState {}

class ProposalDetailLoaded extends ProposalDetailState {
  final ProposalsModel proposal;
  const ProposalDetailLoaded({required this.proposal});

  @override
  List<Object> get props => [proposal];
}

class ProposalDetailError extends ProposalDetailState{
  final String message;
  const ProposalDetailError({required this.message});

  @override
  List<Object> get props => [message];
}