import 'package:bsi_general_affair_apps/domain/entities/assets_entity.dart';
import 'package:equatable/equatable.dart';

import '../brands/brands_model.dart';
import 'asset_categories_model.dart';

class AssetsModel extends AssetsEntity with EquatableMixin{
  AssetsModel({required super.assetId, required super.brandId, required super.assetCategoryId, required super.assetFactoryNumber, required super.assetNumber, required super.asssetName, required super.assetCost, required super.assetProcurementDate, required super.assetFlagActive, required super.assetCondition, required super.createdAt, required super.assetCategory, required super.brand});

  factory AssetsModel.fromJson(Map<String, dynamic> json){
    return AssetsModel(
      assetId: json["AssetId"] ?? 0,
      brandId: json["BrandId"] ?? 0,
      assetCategoryId: json["AssetCategoryId"] ?? 0,
      assetFactoryNumber: json["AssetFactoryNumber"] ?? "",
      assetNumber: json["AssetNumber"] ?? "",
      asssetName: json["AsssetName"] ?? "",
      assetCost: int.parse(json["AssetCost"].toString().replaceAll(RegExp(r'[^0-9]'), ''))  ?? 0,
      assetProcurementDate: DateTime.tryParse(json["AssetProcurementDate"] ?? ""),
      assetFlagActive: json["AssetFlagActive"] ?? false,
      assetCondition: json["AssetCondition"] ?? "",
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      assetCategory: json["AssetCategory"] == null ? null : AssetCategoriesModel.fromJson(json["AssetCategory"]),
      brand: json["Brand"] == null ? null : BrandsModel.fromJson(json["Brand"]),
    );
  }
}