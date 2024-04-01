import '../../data/models/proposals/proposals_create_model.dart';
import '../../data/models/proposals/proposals_model.dart';
import '../../data/models/proposals/proposals_update_model.dart';
import '../failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProposalsRepo{
  Future<Either<Failure, List<ProposalsModel>>> getProposalWaitingData(String employeeNumber);
  Future<Either<Failure, List<ProposalsModel>>> getProposalHistoryData(String employeeNumber, String typeProposal);
  Future<Either<Failure, ProposalsModel>> getProposalDetailData(String proposalToken);
  Future<ProposalsModel> getProposalDetailDataEdit(String proposalToken);
  Future<Either<Failure, String>> postProposalUpdateData(ProposalsUpdateModel proposalsUpdateModel);
  Future<Either<Failure, String>> postProposalCreateData(ProposalsCreateModel proposalsCreateModel);
  Future<Either<Failure, String>> deleteProposalCancelData(String proposalToken);
}
