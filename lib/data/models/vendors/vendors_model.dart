
import 'package:bsi_general_affair_apps/domain/entities/vendors_entity.dart';
import 'package:equatable/equatable.dart';

class VendorsModel extends VendorsEntity with EquatableMixin{
  VendorsModel({required super.vendorId, required super.vendorName, required super.vendorAddress, required super.createdAt, required super.updatedAt, required super.proposals});

  factory VendorsModel.fromJson(Map<String, dynamic> json) {
    return VendorsModel(
        vendorId: json["VendorId"] ?? 0,
        vendorName: json["VendorName"] ?? "",
        vendorAddress: json["VendorAddress"] ?? "",
        createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
        updatedAt: json["UpdatedAt"] ?? "kosong",
        proposals: json["Proposals"] == null ? [] : List<dynamic>.from(json["Proposals"]!.map((x) => x))
    );
  }
}