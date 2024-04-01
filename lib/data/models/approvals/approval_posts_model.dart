import 'package:equatable/equatable.dart';

class ApprovalPostsModel extends Equatable {
  ApprovalPostsModel({
    required this.proposalToken,
    required this.employeeIdNumber,
    required this.approvalReason,
    required this.approvalStatus,
  });

  final String proposalToken;
  final String employeeIdNumber;
  final String approvalReason;
  final String approvalStatus;

  factory ApprovalPostsModel.fromJson(Map<String, dynamic> json){
    return ApprovalPostsModel(
      proposalToken: json["ProposalToken"] ?? "",
      employeeIdNumber: json["EmployeeIDNumber"] ?? "",
      approvalReason: json["ApprovalReason"] ?? "",
      approvalStatus: json["ApprovalStatus"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "ProposalToken": proposalToken,
    "EmployeeIDNumber": employeeIdNumber,
    "ApprovalReason": approvalReason,
    "ApprovalStatus": approvalStatus,
  };

  @override
  String toString(){
    return "$proposalToken, $employeeIdNumber, $approvalReason, $approvalStatus, ";
  }

  @override
  List<Object?> get props => [
    proposalToken, employeeIdNumber, approvalReason, approvalStatus, ];

}