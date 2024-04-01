

import 'package:bsi_general_affair_apps/data/models/departements/departements_model.dart';
import 'package:bsi_general_affair_apps/domain/entities/proposals_entity.dart';
import 'package:equatable/equatable.dart';

import '../users/users_model.dart';
import '../vendors/vendors_model.dart';

class ProposalsModel extends ProposalsEntity with EquatableMixin{
  ProposalsModel({required super.proposalToken, required super.departementId, required super.userId, required super.vendorId, required super.proposalObjective, required super.proposalDescription, required super.proposalRequireDate, required super.proposalBudget, required super.proposalNote, required super.proposalType, required super.proposalStatus, required super.proposalApproveLevel, required super.proposalNegotiationNote, required super.createdAt, required super.updatedAt, required super.departement, required super.user, required super.vendor});

  factory ProposalsModel.fromJson(Map<String, dynamic> json) {
    return ProposalsModel(
      proposalToken: json["ProposalToken"] ?? "",
      departementId: json["DepartementId"] ?? 0,
      userId: json["UserId"] ?? 0,
      vendorId: json["VendorId"],
      proposalObjective: json["ProposalObjective"] ?? "",
      proposalDescription: json["ProposalDescription"] ?? "",
      proposalRequireDate: DateTime.tryParse(json["ProposalRequireDate"] ?? ""),
      proposalBudget: int.parse(json["ProposalBudget"].toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      proposalNote: json["ProposalNote"] ?? "",
      proposalType: json["ProposalType"] ?? "",
      proposalStatus: json["ProposalStatus"] ?? "",
      proposalApproveLevel: json["ProposalApproveLevel"] ?? 0,
      proposalNegotiationNote: json["ProposalNegotiationNote"] ?? "",
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      updatedAt: json["UpdatedAt"],
      departement: json["Departement"] == null ? null : DepartementsModel.fromJson(json["Departement"]),
      user: json["User"] == null ? null : UsersModel.fromJson(json["User"]),
      vendor: json["Vendor"] == null ? null : VendorsModel.fromJson(json["Vendor"]),
    );
  }
}