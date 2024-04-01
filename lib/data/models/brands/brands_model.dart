import 'package:bsi_general_affair_apps/domain/entities/brands_entity.dart';
import 'package:equatable/equatable.dart';

class BrandsModel extends BrandsEntity with EquatableMixin{
  BrandsModel({required super.brandId, required super.brandName});

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      brandId: json["BrandId"] ?? 0,
      brandName: json["BrandName"] ?? "",
    );
  }

}