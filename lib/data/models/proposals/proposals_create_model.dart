import 'package:equatable/equatable.dart';

class ProposalsCreateModel extends Equatable {
  ProposalsCreateModel({
    required this.employeeIdnumber,
    required this.assetNumber,
    required this.proposalObjective,
    required this.proposalDescription,
    required this.proposalRequireDate,
    required this.proposalBudget,
    required this.proposalNote,
    required this.proposalType,
  });

  final String employeeIdnumber;
  final String assetNumber;
  final String proposalObjective;
  final String proposalDescription;
  final DateTime? proposalRequireDate;
  final int proposalBudget;
  final String proposalNote;
  final String proposalType;

  factory ProposalsCreateModel.fromJson(Map<String, dynamic> json){
    return ProposalsCreateModel(
      employeeIdnumber: json["EmployeeIdnumber"] ?? "",
      assetNumber: json["AssetNumber"] ?? "",
      proposalObjective: json["ProposalObjective"] ?? "",
      proposalDescription: json["ProposalDescription"] ?? "",
      proposalRequireDate: DateTime.tryParse(json["ProposalRequireDate"] ?? ""),
      proposalBudget: json["ProposalBudget"] ?? 0,
      proposalNote: json["ProposalNote"] ?? "",
      proposalType: json["ProposalType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "EmployeeIdnumber": employeeIdnumber,
    "AssetNumber": assetNumber,
    "ProposalObjective": proposalObjective,
    "ProposalDescription": proposalDescription,
    "ProposalRequireDate": proposalRequireDate?.toIso8601String(),
    "ProposalBudget": proposalBudget,
    "ProposalNote": proposalNote,
    "ProposalType": proposalType,
  };

  @override
  String toString(){
    return "$employeeIdnumber, $assetNumber, $proposalObjective, $proposalDescription, $proposalRequireDate, $proposalBudget, $proposalNote, $proposalType, ";
  }

  @override
  List<Object?> get props => [
    employeeIdnumber, assetNumber, proposalObjective, proposalDescription, proposalRequireDate, proposalBudget, proposalNote, proposalType, ];

}