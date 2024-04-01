

import 'package:bsi_general_affair_apps/domain/entities/departements_entity.dart';
import 'package:equatable/equatable.dart';

class DepartementsModel extends DepartementsEntity with EquatableMixin{
  DepartementsModel({required super.departementId, required super.departementName, required super.updatedAt, required super.employees, required super.proposals});

  factory DepartementsModel.fromJson(Map<String, dynamic> json) {
    return DepartementsModel(
        departementId: json["DepartementId"] ?? 0,
        departementName: json["DepartementName"] ?? "",
        updatedAt: json["UpdatedAt"],
        employees: json["Employees"] == null ? [] : List<dynamic>.from(json["Employees"]!.map((x) => x)),
        proposals: json["Proposals"] == null ? [] : List<dynamic>.from(json["Proposals"]!.map((x) => x))
    );
  }
}