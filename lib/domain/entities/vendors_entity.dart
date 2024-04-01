import 'package:equatable/equatable.dart';

class VendorsEntity extends Equatable {
  VendorsEntity({
    required this.vendorId,
    required this.vendorName,
    required this.vendorAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.proposals,
  });

  final int vendorId;
  final String vendorName;
  final String vendorAddress;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final List<dynamic> proposals;

  factory VendorsEntity.fromJson(Map<String, dynamic> json){
    return VendorsEntity(
      vendorId: json["VendorId"] ?? 0,
      vendorName: json["VendorName"] ?? "",
      vendorAddress: json["VendorAddress"] ?? "",
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      updatedAt: json["UpdatedAt"],
      proposals: json["Proposals"] == null ? [] : List<dynamic>.from(json["Proposals"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "VendorId": vendorId,
    "VendorName": vendorName,
    "VendorAddress": vendorAddress,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt,
    "Proposals": proposals.map((x) => x).toList(),
  };

  @override
  String toString(){
    return "$vendorId, $vendorName, $vendorAddress, $createdAt, $updatedAt, $proposals, ";
  }

  @override
  List<Object?> get props => [
    vendorId, vendorName, vendorAddress, createdAt, updatedAt, proposals, ];

}