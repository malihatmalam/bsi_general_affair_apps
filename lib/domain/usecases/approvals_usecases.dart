import 'package:bsi_general_affair_apps/data/repositories/approvals_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../data/models/approvals/approval_posts_model.dart';
import '../../data/models/approvals/approvals_model.dart';
import '../../presentation/core/services/auth_services.dart';
import '../../presentation/core/services/dropdown_service.dart';
import '../failures/failures.dart';

class ApprovalsUseCases {
  final approvalRepo = ApprovalsRepoImpl();

  Future<Either<Failure, List<ApprovalsModel>>> getApprovalByProposalTokenData(
      String proposalToken) {
    // TODO: implement getApprovalByProposalTokenData
    return approvalRepo.getApprovalByProposalTokenData(proposalToken);
  }

  Future<void> postApprovalData({
    required ApprovalPostsModel approvalPostsModel, required BuildContext context }) async {
    var _isApproving = Provider.of<AuthService>(context, listen: false)
        .getIsApproving();
    print(_isApproving);
    Provider.of<AuthService>(context, listen: false).changeIsApproving();

    var box = Hive.box('userdata');
    var failureOrApproval = await approvalRepo.postApprovalData(
        approvalPostsModel);
    failureOrApproval.fold(
            (failure) {
          _isApproving =
              Provider.of<AuthService>(context, listen: false).getIsApproving();
          print(_isApproving);
          Provider.of<AuthService>(context, listen: false).changeIsApproving();
          _isApproving =
              Provider.of<AuthService>(context, listen: false).getIsApproving();
          print(_isApproving);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Approval failed',
                style: TextStyle(fontWeight: FontWeight.bold),)));
        },
            (approve) {
              Provider.of<DropdownService>(context, listen: false)
                  .changeStatusApproval(null);
          Provider.of<AuthService>(context, listen: false)
              .changeIsAuthenticating();
              _isApproving =
                  Provider.of<AuthService>(context, listen: false).getIsApproving();
              print(_isApproving);
              Provider.of<AuthService>(context, listen: false).changeIsApproving();
              _isApproving =
                  Provider.of<AuthService>(context, listen: false).getIsApproving();
              print(_isApproving);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.lightBlueAccent,
                  content: Text(approve,
                    style: TextStyle(fontWeight: FontWeight.bold),)));
              print("result : ${approve}");
              context.go('/');
        }
    );
  }
}
