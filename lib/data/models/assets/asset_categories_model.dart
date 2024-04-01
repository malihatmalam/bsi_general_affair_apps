import 'package:bsi_general_affair_apps/domain/entities/asset_categories_entity.dart';
import 'package:equatable/equatable.dart';

class AssetCategoriesModel extends AssetCategoriesEntity with EquatableMixin{
  AssetCategoriesModel({required super.assetCategoryId, required super.assetCategoryName});

  factory AssetCategoriesModel.fromJson(Map<String, dynamic> json){
    return AssetCategoriesModel(
      assetCategoryId: json["AssetCategoryId"] ?? 0,
      assetCategoryName: json["AssetCategoryName"] ?? "",
      // updatedAt: json["UpdatedAt"],
      // assets: json["Assets"] == null ? [] : List<dynamic>.from(json["Assets"]!.map((x) => x)),
    );
  }
}