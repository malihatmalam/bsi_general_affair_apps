import 'package:equatable/equatable.dart';

import 'asset_categories_entity.dart';
import 'brands_entity.dart';

class AssetsEntity extends Equatable {
  AssetsEntity({
    required this.assetId,
    required this.brandId,
    required this.assetCategoryId,
    required this.assetFactoryNumber,
    required this.assetNumber,
    required this.asssetName,
    required this.assetCost,
    required this.assetProcurementDate,
    required this.assetFlagActive,
    required this.assetCondition,
    required this.createdAt,
    // required this.updatedAt,
    required this.assetCategory,
    // required this.assetUsers,
    required this.brand,
    // required this.proposalServices,
  });

  final int assetId;
  final int brandId;
  final int assetCategoryId;
  final String assetFactoryNumber;
  final String assetNumber;
  final String asssetName;
  final int assetCost;
  final DateTime? assetProcurementDate;
  final bool assetFlagActive;
  final String assetCondition;
  final DateTime? createdAt;
  // final dynamic updatedAt;
  final AssetCategoriesEntity? assetCategory;
  // final List<dynamic> assetUsers;
  final BrandsEntity? brand;
  // final List<dynamic> proposalServices;

  factory AssetsEntity.fromJson(Map<String, dynamic> json){
    return AssetsEntity(
      assetId: json["AssetId"] ?? 0,
      brandId: json["BrandId"] ?? 0,
      assetCategoryId: json["AssetCategoryId"] ?? 0,
      assetFactoryNumber: json["AssetFactoryNumber"] ?? "",
      assetNumber: json["AssetNumber"] ?? "",
      asssetName: json["AsssetName"] ?? "",
      assetCost: json["AssetCost"] ?? 0,
      assetProcurementDate: DateTime.tryParse(json["AssetProcurementDate"] ?? ""),
      assetFlagActive: json["AssetFlagActive"] ?? false,
      assetCondition: json["AssetCondition"] ?? "",
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      // updatedAt: json["UpdatedAt"],
      assetCategory: json["AssetCategory"] == null ? null : AssetCategoriesEntity.fromJson(json["AssetCategory"]),
      // assetUsers: json["AssetUsers"] == null ? [] : List<dynamic>.from(json["AssetUsers"]!.map((x) => x)),
      brand: json["Brand"] == null ? null : BrandsEntity.fromJson(json["Brand"]),
      // proposalServices: json["ProposalServices"] == null ? [] : List<dynamic>.from(json["ProposalServices"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "AssetId": assetId,
    "BrandId": brandId,
    "AssetCategoryId": assetCategoryId,
    "AssetFactoryNumber": assetFactoryNumber,
    "AssetNumber": assetNumber,
    "AsssetName": asssetName,
    "AssetCost": assetCost,
    "AssetProcurementDate": assetProcurementDate?.toIso8601String(),
    "AssetFlagActive": assetFlagActive,
    "AssetCondition": assetCondition,
    "CreatedAt": createdAt?.toIso8601String(),
    // "UpdatedAt": updatedAt,
    "AssetCategory": assetCategory?.toJson(),
    // "AssetUsers": assetUsers.map((x) => x).toList(),
    "Brand": brand?.toJson(),
    // "ProposalServices": proposalServices.map((x) => x).toList(),
  };

  @override
  String toString(){
    return ""
        "$assetId, "
        "$brandId, "
        "$assetCategoryId, "
        "$assetFactoryNumber, "
        "$assetNumber, "
        "$asssetName, "
        "$assetCost, "
        "$assetProcurementDate, "
        "$assetFlagActive, "
        "$assetCondition, "
        "$createdAt, "
        // "$updatedAt, "
        "$assetCategory, "
        // "$assetUsers, "
        "$brand, "
        // "$proposalServices, "
    ;
  }

  @override
  List<Object?> get props => [
    assetId,
    brandId,
    assetCategoryId,
    assetFactoryNumber,
    assetNumber,
    asssetName,
    assetCost,
    assetProcurementDate,
    assetFlagActive,
    assetCondition,
    createdAt,
    // updatedAt,
    assetCategory,
    // assetUsers,
    brand,
    // proposalServices,
  ];

}