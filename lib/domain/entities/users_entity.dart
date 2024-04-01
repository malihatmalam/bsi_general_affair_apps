import 'package:equatable/equatable.dart';

class UsersEntity extends Equatable {
  UsersEntity({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userUsername,
    required this.userPassword,
    required this.userToken,
    required this.userRole,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    // required this.approvals,
    // required this.assetUsers,
    // required this.employees,
    // required this.proposals,
  });

  final int userId;
  final String userFirstName;
  final dynamic userLastName;
  final dynamic userUsername;
  final dynamic userPassword;
  final dynamic userToken;
  final dynamic userRole;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  // final List<dynamic> approvals;
  // final List<dynamic> assetUsers;
  // final List<dynamic> employees;
  // final List<dynamic> proposals;

  factory UsersEntity.fromJson(Map<String, dynamic> json){
    return UsersEntity(
      userId: json["UserId"] ?? 0,
      userFirstName: json["UserFirstName"] ?? "",
      userLastName: json["UserLastName"],
      userUsername: json["UserUsername"],
      userPassword: json["UserPassword"],
      userToken: json["UserToken"],
      userRole: json["UserRole"],
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      updatedAt: json["UpdatedAt"],
      deletedAt: json["DeletedAt"],
      // approvals: json["Approvals"] == null ? [] : List<dynamic>.from(json["Approvals"]!.map((x) => x)),
      // assetUsers: json["AssetUsers"] == null ? [] : List<dynamic>.from(json["AssetUsers"]!.map((x) => x)),
      // employees: json["Employees"] == null ? [] : List<dynamic>.from(json["Employees"]!.map((x) => x)),
      // proposals: json["Proposals"] == null ? [] : List<dynamic>.from(json["Proposals"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "UserFirstName": userFirstName,
    "UserLastName": userLastName,
    "UserUsername": userUsername,
    "UserPassword": userPassword,
    "UserToken": userToken,
    "UserRole": userRole,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt,
    "DeletedAt": deletedAt,
    // "Approvals": approvals.map((x) => x).toList(),
    // "AssetUsers": assetUsers.map((x) => x).toList(),
    // "Employees": employees.map((x) => x).toList(),
    // "Proposals": proposals.map((x) => x).toList(),
  };

  @override
  String toString(){
    return
      "$userId, "
          "$userFirstName, "
          "$userLastName, "
          "$userUsername, "
          "$userPassword, "
          "$userToken, "
          "$userRole, "
          "$createdAt, "
          "$updatedAt, "
          "$deletedAt "
          // "$approvals, "
          // "$assetUsers, "
          // "$employees, "
          // "$proposals, "
    ;
  }

  @override
  List<Object?> get props => [
    userId,
    userFirstName,
    userLastName,
    userUsername,
    userPassword,
    userToken,
    userRole,
    createdAt,
    updatedAt,
    deletedAt,
    // approvals,
    // assetUsers,
    // employees,
    // proposals,
  ];
}