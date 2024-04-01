import 'package:bsi_general_affair_apps/domain/entities/approvals_entity.dart';
import 'package:equatable/equatable.dart';

class ApprovalsModel extends ApprovalsEntity with EquatableMixin{
  ApprovalsModel({required super.employeeIdNumber, required super.approverName, required super.approverPosition, required super.approvalId, required super.proposalToken, required super.approvalUserId, required super.approvalStatus, required super.approvalReason, required super.approvalLevel, required super.approvalAt, required super.approvalUser, required super.proposalTokenNavigation});

  factory ApprovalsModel.fromJson(Map<String, dynamic> json){
    return ApprovalsModel(
      employeeIdNumber: json["EmployeeIDNumber"],
      approverName: json["ApproverName"] ?? "",
      approverPosition: json["ApproverPosition"] ?? "",
      approvalId: json["ApprovalId"] ?? 0,
      proposalToken: json["ProposalToken"],
      approvalUserId: json["ApprovalUserId"] ?? 0,
      approvalStatus: json["ApprovalStatus"] ?? "",
      approvalReason: json["ApprovalReason"] ?? "",
      approvalLevel: json["ApprovalLevel"] ?? 0,
      approvalAt: DateTime.tryParse(json["ApprovalAt"] ?? ""),
      approvalUser: json["ApprovalUser"],
      proposalTokenNavigation: json["ProposalTokenNavigation"],
    );
  }
}