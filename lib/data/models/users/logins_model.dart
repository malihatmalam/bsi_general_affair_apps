
import 'package:equatable/equatable.dart';


class LoginsModel extends Equatable {
  String? userUsername;
  String? userPassword;

  LoginsModel({
    required this.userUsername, required this.userPassword
  });

  factory LoginsModel.fromJson(Map<String, dynamic> json) {
    return LoginsModel(
        userUsername: json['UserUsername'] ?? 'kosong',
        userPassword: json['UserPassword'] ?? 'kosong'
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserUsername'] = this.userUsername;
    data['UserPassword'] = this.userPassword;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userUsername,userPassword];
  String toString(){
    return 'LoginModel{username: ${userUsername}, password: ${userPassword} }';
  }
}