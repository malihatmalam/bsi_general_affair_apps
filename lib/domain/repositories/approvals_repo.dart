
import 'package:dartz/dartz.dart';

import '../../data/models/approvals/approval_posts_model.dart';
import '../../data/models/approvals/approvals_model.dart';
import '../failures/failures.dart';

abstract class ApprovalsRepo{
  Future<Either<Failure,List<ApprovalsModel>>> getApprovalByProposalTokenData(String proposalToken);
  Future<Either<Failure,String>> postApprovalData(ApprovalPostsModel approvalPostsModel);
}