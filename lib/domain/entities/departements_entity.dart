import 'package:equatable/equatable.dart';

class DepartementsEntity extends Equatable {
  DepartementsEntity({
    required this.departementId,
    required this.departementName,
    required this.updatedAt,
    required this.employees,
    required this.proposals,
  });

  final int departementId;
  final String departementName;
  final dynamic updatedAt;
  final List<dynamic> employees;
  final List<dynamic> proposals;

  factory DepartementsEntity.fromJson(Map<String, dynamic> json){
    return DepartementsEntity(
      departementId: json["DepartementId"] ?? 0,
      departementName: json["DepartementName"] ?? "",
      updatedAt: json["UpdatedAt"],
      employees: json["Employees"] == null ? [] : List<dynamic>.from(json["Employees"]!.map((x) => x)),
      proposals: json["Proposals"] == null ? [] : List<dynamic>.from(json["Proposals"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "DepartementId": departementId,
    "DepartementName": departementName,
    "UpdatedAt": updatedAt,
    "Employees": employees.map((x) => x).toList(),
    "Proposals": proposals.map((x) => x).toList(),
  };

  @override
  String toString(){
    return "$departementId, $departementName, $updatedAt, $employees, $proposals, ";
  }

  @override
  List<Object?> get props => [
    departementId, departementName, updatedAt, employees, proposals, ];

}