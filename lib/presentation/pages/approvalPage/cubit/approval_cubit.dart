import 'package:bloc/bloc.dart';
import 'package:bsi_general_affair_apps/data/models/approvals/approvals_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/approvals_usecases.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/failures/failures.dart';

part 'approval_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class ApprovalCubit extends Cubit<ApprovalState> {
  final ApprovalsUseCases _approvalsUseCases = ApprovalsUseCases();
  String? proposalToken;
  ApprovalCubit({required this.proposalToken}) : super(ApprovalInitial()){
    getApproval(proposalToken!);
  }

  void getApproval(String proposalToken) async {
    emit(ApprovalLoading());
    final failureOrApproval = await _approvalsUseCases.getApprovalByProposalTokenData(proposalToken);
    failureOrApproval.fold(
            (failure) => emit(ApprovalError(message: _mapFailureToMessage(failure))),
            (approvals) => emit(ApprovalLoaded(approvals: approvals))
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}