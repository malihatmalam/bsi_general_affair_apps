
import 'package:bsi_general_affair_apps/domain/entities/users_entity.dart';
import 'package:equatable/equatable.dart';

class UsersModel extends UsersEntity with EquatableMixin{
  UsersModel({
    required super.userId,
    required super.userFirstName,
    required super.userLastName,
    required super.userUsername,
    required super.userPassword,
    required super.userToken,
    required super.userRole,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      userId: json["UserId"] ?? 0,
      userFirstName: json["UserFirstName"] ?? "",
      userLastName: json["UserLastName"],
      userUsername: json["UserUsername"],
      userPassword: json["UserPassword"],
      userToken: json["UserToken"],
      userRole: json["UserRole"],
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? ""),
      updatedAt: json["UpdatedAt"],
      deletedAt: json["DeletedAt"]
    );
  }
}