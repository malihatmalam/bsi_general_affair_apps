import 'package:equatable/equatable.dart';

class ProposalsUpdateModel extends Equatable {
  ProposalsUpdateModel({
    required this.proposalToken,
    required this.proposalObjective,
    required this.proposalDescription,
    required this.proposalRequireDate,
    required this.proposalBudget,
    required this.proposalNote,
    required this.proposalNegotiationNote,
  });

  final String proposalToken;
  final String proposalObjective;
  final String proposalDescription;
  final DateTime? proposalRequireDate;
  final int proposalBudget;
  final String proposalNote;
  final String proposalNegotiationNote;

  factory ProposalsUpdateModel.fromJson(Map<String, dynamic> json){
    return ProposalsUpdateModel(
      proposalToken: json["ProposalToken"] ?? "",
      proposalObjective: json["ProposalObjective"] ?? "",
      proposalDescription: json["ProposalDescription"] ?? "",
      proposalRequireDate: DateTime.tryParse(json["ProposalRequireDate"] ?? ""),
      proposalBudget: json["ProposalBudget"] ?? 0,
      proposalNote: json["ProposalNote"] ?? "",
      proposalNegotiationNote: json["ProposalNegotiationNote"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "ProposalToken": proposalToken,
    "ProposalObjective": proposalObjective,
    "ProposalDescription": proposalDescription,
    "ProposalRequireDate": proposalRequireDate?.toIso8601String(),
    "ProposalBudget": proposalBudget,
    "ProposalNote": proposalNote,
    "ProposalNegotiationNote": proposalNegotiationNote,
  };

  @override
  String toString(){
    return "$proposalToken, $proposalObjective, $proposalDescription, $proposalRequireDate, $proposalBudget, $proposalNote, $proposalNegotiationNote, ";
  }

  @override
  List<Object?> get props => [
    proposalToken, proposalObjective, proposalDescription, proposalRequireDate, proposalBudget, proposalNote, proposalNegotiationNote, ];

}