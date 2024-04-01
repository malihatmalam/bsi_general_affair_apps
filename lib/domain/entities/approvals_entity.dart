import 'package:equatable/equatable.dart';

class ApprovalsEntity extends Equatable {
  ApprovalsEntity({
    required this.employeeIdNumber,
    required this.approverName,
    required this.approverPosition,
    required this.approvalId,
    required this.proposalToken,
    required this.approvalUserId,
    required this.approvalStatus,
    required this.approvalReason,
    required this.approvalLevel,
    required this.approvalAt,
    required this.approvalUser,
    required this.proposalTokenNavigation,
  });

  final dynamic employeeIdNumber;
  final String approverName;
  final String approverPosition;
  final int approvalId;
  final dynamic proposalToken;
  final int approvalUserId;
  final String approvalStatus;
  final String approvalReason;
  final int approvalLevel;
  final DateTime? approvalAt;
  final dynamic approvalUser;
  final dynamic proposalTokenNavigation;

  factory ApprovalsEntity.fromJson(Map<String, dynamic> json){
    return ApprovalsEntity(
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

  Map<String, dynamic> toJson() => {
    "EmployeeIDNumber": employeeIdNumber,
    "ApproverName": approverName,
    "ApproverPosition": approverPosition,
    "ApprovalId": approvalId,
    "ProposalToken": proposalToken,
    "ApprovalUserId": approvalUserId,
    "ApprovalStatus": approvalStatus,
    "ApprovalReason": approvalReason,
    "ApprovalLevel": approvalLevel,
    "ApprovalAt": approvalAt?.toIso8601String(),
    "ApprovalUser": approvalUser,
    "ProposalTokenNavigation": proposalTokenNavigation,
  };

  @override
  String toString(){
    return "$employeeIdNumber, $approverName, $approverPosition, $approvalId, $proposalToken, $approvalUserId, $approvalStatus, $approvalReason, $approvalLevel, $approvalAt, $approvalUser, $proposalTokenNavigation, ";
  }

  @override
  List<Object?> get props => [
    employeeIdNumber, approverName, approverPosition, approvalId, proposalToken, approvalUserId, approvalStatus, approvalReason, approvalLevel, approvalAt, approvalUser, proposalTokenNavigation, ];

}