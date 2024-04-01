import 'package:bloc/bloc.dart';
import 'package:bsi_general_affair_apps/domain/usecases/proposals_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/proposals/proposals_model.dart';
import '../../../../domain/failures/failures.dart';

part 'proposal_history_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class ProposalHistoryCubit extends Cubit<ProposalHistoryState> {
  final ProposalsUseCases _proposalsUseCases = ProposalsUseCases();
  String? typeProposal;
  ProposalHistoryCubit({required this.typeProposal}) : super(ProposalHistoryInitial()){
    proposalHistoryGetData(typeProposal!);
  }

  void proposalHistoryGetData(String typeProposal) async {
    var box = Hive.box('userdata');
    emit(ProposalHistoryLoading());
    final failureOrProposalHistory = await _proposalsUseCases.getProposalHistory(
        box.get('employeeNumber'), typeProposal);
    failureOrProposalHistory.fold(
            (failure) => emit(ProposalHistoryError(message: _mapFailureToMessage(failure))),
            (proposals) => emit(ProposalHistoryLoaded(proposals: proposals))
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
