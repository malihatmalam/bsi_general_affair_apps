import 'package:equatable/equatable.dart';

class AssetCategoriesEntity extends Equatable {
  AssetCategoriesEntity({
    required this.assetCategoryId,
    required this.assetCategoryName,
    // required this.updatedAt,
    // required this.assets,
  });

  final int assetCategoryId;
  final String assetCategoryName;
  // final dynamic updatedAt;
  // final List<dynamic> assets;

  factory AssetCategoriesEntity.fromJson(Map<String, dynamic> json){
    return AssetCategoriesEntity(
      assetCategoryId: json["AssetCategoryId"] ?? 0,
      assetCategoryName: json["AssetCategoryName"] ?? "",
      // updatedAt: json["UpdatedAt"],
      // assets: json["Assets"] == null ? [] : List<dynamic>.from(json["Assets"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "AssetCategoryId": assetCategoryId,
    "AssetCategoryName": assetCategoryName,
    // "UpdatedAt": updatedAt,
    // "Assets": assets.map((x) => x).toList(),
  };

  @override
  String toString(){
    return ""
        "$assetCategoryId, "
        "$assetCategoryName, "
        // "$updatedAt, "
        // "$assets, "
    ;
  }

  @override
  List<Object?> get props => [
    assetCategoryId,
    assetCategoryName,
    // updatedAt,
    // assets,
  ];

}