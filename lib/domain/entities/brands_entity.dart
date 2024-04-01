import 'package:equatable/equatable.dart';

class BrandsEntity extends Equatable {
  const BrandsEntity({
    required this.brandId,
    required this.brandName,
    // required this.updatedAt,
    // required this.assets,
  });

  final int brandId;
  final String brandName;
  // final dynamic updatedAt;
  // final List<dynamic> assets;

  factory BrandsEntity.fromJson(Map<String, dynamic> json){
    return BrandsEntity(
      brandId: json["BrandId"] ?? 0,
      brandName: json["BrandName"] ?? "",
      // updatedAt: json["UpdatedAt"],
      // assets: json["Assets"] == null ? [] : List<dynamic>.from(json["Assets"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "BrandId": brandId,
    "BrandName": brandName,
    // "UpdatedAt": updatedAt,
    // "Assets": assets.map((x) => x).toList(),
  };

  @override
  String toString(){
    return "$brandId, "
        "$brandName, "
        // "$updatedAt, "
        // "$assets, "
    ;
  }

  @override
  List<Object?> get props => [
    brandId,
    brandName,
    // updatedAt,
    // assets,
  ];

}