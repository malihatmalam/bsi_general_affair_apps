part of 'approval_cubit.dart';

abstract class ApprovalState extends Equatable {
  const ApprovalState();
  @override
  List<Object> get props => [];
}

class ApprovalInitial extends ApprovalState {}

class ApprovalLoading extends ApprovalState {}

class ApprovalLoaded extends ApprovalState {
  final List<ApprovalsModel> approvals;
  const ApprovalLoaded({required this.approvals});

  @override
  List<Object> get props => [approvals];
}

class ApprovalError extends ApprovalState{
  final String message;
  const ApprovalError({required this.message});

  @override
  List<Object> get props => [message];
}
