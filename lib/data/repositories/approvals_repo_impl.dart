
import 'package:bsi_general_affair_apps/data/datasource/api/approval_remote_datasource.dart';
import 'package:bsi_general_affair_apps/data/models/approvals/approval_posts_model.dart';
import 'package:bsi_general_affair_apps/data/models/approvals/approvals_model.dart';
import 'package:bsi_general_affair_apps/domain/failures/failures.dart';
import 'package:bsi_general_affair_apps/domain/repositories/approvals_repo.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/exceptions.dart';

class ApprovalsRepoImpl implements ApprovalsRepo{
  final ApprovalApiRemoteDataSource approvalApiRemoteDataSource =
  ApprovalApiRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<ApprovalsModel>>> getApprovalByProposalTokenData(String proposalToken) async {
    // TODO: implement getApprovalByProposalTokenData
    try{
      final result = await approvalApiRemoteDataSource.getApprovalByProposalToken(proposalToken);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postApprovalData(ApprovalPostsModel approvalPostsModel) async {
    // TODO: implement postApprovalData
    try{
      final result = await approvalApiRemoteDataSource.postApproval(approvalPostsModel);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

}