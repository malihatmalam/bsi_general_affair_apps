import 'package:bsi_general_affair_apps/domain/entities/users_entity.dart';
import 'package:bsi_general_affair_apps/domain/entities/vendors_entity.dart';
import 'package:equatable/equatable.dart';

import 'departements_entity.dart';

class ProposalsEntity extends Equatable {
  ProposalsEntity({
    required this.proposalToken,
    required this.departementId,
    required this.userId,
    required this.vendorId,
    required this.proposalObjective,
    required this.proposalDescription,
    required this.proposalRequireDate,
    required this.proposalBudget,
    required this.proposalNote,
    required this.proposalType,
    required this.proposalStatus,
    required this.proposalApproveLevel,
    required this.proposalNegotiationNote,
    required this.createdAt,
    required this.updatedAt,
    // required this.approvals,
    required this.departement,
    // required this.proposalFiles,
    // required this.proposalServices,
    required this.user,
    required this.vendor,
  });

  final String proposalToken;
  final int departementId;
  final int userId;
  final dynamic vendorId;
  final String proposalObjective;
  final String proposalDescription;
  final DateTime? proposalRequireDate;
  final int proposalBudget;
  final String proposalNote;
  final String proposalType;
  final String proposalStatus;
  final int proposalApproveLevel;
  final String proposalNegotiationNote;
  final DateTime? createdAt;
  final dynamic updatedAt;
  // final List<dynamic> approvals;
  final DepartementsEntity? departement;
  // final List<dynamic> proposalFiles;
  // final List<dynamic> proposalServices;
  final UsersEntity? user;
  final VendorsEntity? vendor;

  factory ProposalsEntity.fromJson(Map<String, dynamic> json){
    return ProposalsEntity(
      proposalToken: json["ProposalToken"] ?? "",
      departementId: json["DepartementId"] ?? 0,
      userId: json["UserId"] ?? 0,
      vendorId: json["VendorId"],
      proposalObjective: json["ProposalObjective"] ?? "",
      proposalDescription: json["ProposalDescription"] ?? "",
      proposalRequireDate: DateTime.tryParse(json["ProposalRequireDate"] ?? ""),
      proposalBudget: json["ProposalBudget"] ?? 0,
      proposalNote: json["ProposalNote"] ?? "",
      proposalType: json["ProposalType"] ?? "",
      proposalStatus: json["ProposalStatus"] ?? "",
      proposalApproveLevel: json["ProposalApproveLevel"] ?? 0,
      proposalNegotiationNote: json["ProposalNegotiationNote"] ?? "",
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      updatedAt: json["UpdatedAt"],
      // approvals: json["Approvals"] == null ? [] : List<dynamic>.from(json["Approvals"]!.map((x) => x)),
      departement: json["Departement"] == null ? null : DepartementsEntity.fromJson(json["Departement"]),
      // proposalFiles: json["ProposalFiles"] == null ? [] : List<dynamic>.from(json["ProposalFiles"]!.map((x) => x)),
      // proposalServices: json["ProposalServices"] == null ? [] : List<dynamic>.from(json["ProposalServices"]!.map((x) => x)),
      user: json["User"] == null ? null : UsersEntity.fromJson(json["User"]),
      vendor: json["Vendor"] == null ? null : VendorsEntity.fromJson(json["Vendor"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "ProposalToken": proposalToken,
    "DepartementId": departementId,
    "UserId": userId,
    "VendorId": vendorId,
    "ProposalObjective": proposalObjective,
    "ProposalDescription": proposalDescription,
    "ProposalRequireDate": proposalRequireDate?.toIso8601String(),
    "ProposalBudget": proposalBudget,
    "ProposalNote": proposalNote,
    "ProposalType": proposalType,
    "ProposalStatus": proposalStatus,
    "ProposalApproveLevel": proposalApproveLevel,
    "ProposalNegotiationNote": proposalNegotiationNote,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt,
    // "Approvals": approvals.map((x) => x).toList(),
    "Departement": departement?.toJson(),
    // "ProposalFiles": proposalFiles.map((x) => x).toList(),
    // "ProposalServices": proposalServices.map((x) => x).toList(),
    "User": user?.toJson(),
    "Vendor": vendor?.toJson(),
  };

  @override
  String toString(){
    return ""
        "$proposalToken, "
        "$departementId, "
        "$userId, "
        "$vendorId, "
        "$proposalObjective, "
        "$proposalDescription, "
        "$proposalRequireDate, "
        "$proposalBudget, "
        "$proposalNote, "
        "$proposalType, "
        "$proposalStatus, "
        "$proposalApproveLevel, "
        "$proposalNegotiationNote, "
        "$createdAt, "
        "$updatedAt, "
        // "$approvals, "
        "$departement, "
        // "$proposalFiles, "
        // "$proposalServices, "
        "$user, "
        "$vendor, ";
  }

  @override
  List<Object?> get props => [
    proposalToken,
    departementId,
    userId,
    vendorId,
    proposalObjective,
    proposalDescription,
    proposalRequireDate,
    proposalBudget,
    proposalNote,
    proposalType,
    proposalStatus,
    proposalApproveLevel,
    proposalNegotiationNote,
    createdAt,
    updatedAt,
    // approvals,
    departement,
    // proposalFiles,
    // proposalServices,
    user,
    vendor,
  ];

}