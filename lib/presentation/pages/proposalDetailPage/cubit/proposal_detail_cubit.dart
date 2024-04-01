import 'package:bloc/bloc.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/proposals_usecases.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/failures/failures.dart';

part 'proposal_detail_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class ProposalDetailCubit extends Cubit<ProposalDetailState> {
  final ProposalsUseCases _proposalsUseCases = ProposalsUseCases();
  String? proposalToken;
  ProposalDetailCubit({required this.proposalToken}) : super(ProposalDetailInitial()){
    getProposalDetail(proposalToken!);
  }

  void getProposalDetail(String proposalToken) async {
    emit(ProposalDetailLoading());
    final failureOrProposalDetail = await _proposalsUseCases.getProposalDetail(proposalToken);
    failureOrProposalDetail.fold(
            (failure) => emit(ProposalDetailError(message: _mapFailureToMessage(failure))),
            (proposal) => emit(ProposalDetailLoaded(proposal: proposal))
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