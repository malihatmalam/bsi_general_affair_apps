
import 'package:equatable/equatable.dart';

class LoginsResponseModel extends Equatable{
  String? username;
  String? password;
  String? token;

  LoginsResponseModel({
    required this.username, required this.password, required this.token
  });

  factory LoginsResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginsResponseModel(
        username: json['Username'] ?? 'Kosong',
        password: json['Password'] ?? 'Kosong',
        token: json['Token'] ?? 'Kosong'
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = username;
    data['Password'] = password;
    data['Token'] = token;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [username, password, token];

  String toString(){
    return 'ResponseLoginModel{username: ${username}, password: ${password},'
        ' token: ${token}';
  }
}