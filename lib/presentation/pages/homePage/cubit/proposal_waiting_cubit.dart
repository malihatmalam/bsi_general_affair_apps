import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../data/models/proposals/proposals_model.dart';
import '../../../../domain/failures/failures.dart';
import '../../../../domain/usecases/proposals_usecases.dart';

part 'proposal_waiting_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class ProposalWaitingCubit extends Cubit<ProposalWaitingState> {
  final ProposalsUseCases _proposalsUseCases = ProposalsUseCases();
  String? typeProposal;
  ProposalWaitingCubit() : super(ProposalWaitingInitial()){
    ProposalWaitingGetData();
  }

  void ProposalWaitingGetData() async {
    var box = Hive.box('userdata');
    emit(ProposalWaitingLoading());
    final failureOrProposalWaiting = await _proposalsUseCases.getProposalWaiting(box.get('employeeNumber'));
    if(box.get('role').toString().trim() == 'Other'){
      print("test");
      failureOrProposalWaiting.fold(
              (failure) => emit(ProposalWaitingError(message: _mapFailureToMessage(failure))),
              (proposals) => emit(ProposalWaitingLoaded(proposals: proposals))
      );
    } else {
      print("cancel");
      emit(ProposalWaitingLoaded(proposals: []));
    }
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
