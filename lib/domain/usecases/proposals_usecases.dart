import 'package:bsi_general_affair_apps/data/repositories/proposals_repo_impl.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/proposals/proposals_create_model.dart';
import '../../data/models/proposals/proposals_model.dart';
import '../../data/models/proposals/proposals_update_model.dart';
import '../failures/failures.dart';

class ProposalsUseCases{
  final proposalRepo = ProposalsRepoImpl();

  Future<Either<Failure, List<ProposalsModel>>> getProposalWaiting(String employeeNumber) {
    // TODO: implement getProposalWaiting
    return proposalRepo.getProposalWaitingData(employeeNumber);
  }

  Future<Either<Failure, List<ProposalsModel>>> getProposalHistory(String employeeNumber, String typeProposal) {
    // TODO: implement getProposalHistory
    return proposalRepo.getProposalHistoryData(employeeNumber, typeProposal);
  }

  Future<Either<Failure, ProposalsModel>> getProposalDetail(String proposalToken) {
    // TODO: implement getProposalDetail
    return proposalRepo.getProposalDetailData(proposalToken);
  }

  Future<ProposalsModel> getProposalDetailEdit(String proposalToken) {
    // TODO: implement getProposalDetail
    return proposalRepo.getProposalDetailDataEdit(proposalToken);
  }

  Future<Either<Failure, String>> postProposalUpdateData(ProposalsUpdateModel proposalsUpdateModel) {
    // TODO: implement postProposalUpdateData
    return proposalRepo.postProposalUpdateData(proposalsUpdateModel);
  }

  Future<Either<Failure, String>> postProposalCreateData(ProposalsCreateModel proposalsCreateModel) {
    // TODO: implement postProposalCreateData
    return proposalRepo.postProposalCreateData(proposalsCreateModel);
  }

  Future<Either<Failure, String>> deleteProposalCancelData(String proposalToken) {
    // TODO: implement deleteProposalCancelData
    return proposalRepo.deleteProposalCancelData(proposalToken);
  }

}