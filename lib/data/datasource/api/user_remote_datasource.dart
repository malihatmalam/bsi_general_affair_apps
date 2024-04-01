
import 'dart:convert';

import 'package:bsi_general_affair_apps/data/models/users/logins_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/exceptions.dart';
import '../../models/users/logins_response_model.dart';
import '../../models/users/users_model.dart';

abstract class UserApiRemoteDataSource{
  Future<List<UsersModel>> getUserAll();
  Future<UsersModel> getUserByUsername(String username);
  Future<LoginsResponseModel> postUserLogin(LoginsModel loginsModel);
}
class UserApiRemoteDataSourceImpl implements UserApiRemoteDataSource{
  final String Url = "https://app.actualsolusi.com/bsi/BSIGeneralAffair/api/v1/User";
  final client = http.Client();
  var box = Hive.box('userdata');

  @override
  Future<List<UsersModel>> getUserAll() async {
    // TODO: implement getUserAll
    final response = await client.get(
        Uri.parse(Url),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        final List<dynamic> responseBody = json.decode(response.body);

        List<UsersModel> users = (responseBody)
            .map((user) => UsersModel.fromJson(user as Map<String, dynamic>))
            .toList();
        return users;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<UsersModel> getUserByUsername(String username) async {
    // TODO: implement getUserByUsername
    print(username);
    final response = await client.get(
        Uri.parse(Url + '/${username}'),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    try{
      if (response.statusCode != 200){
        print('Server error : ${response.statusCode}');
        throw ServerException();
      } else {
        final dynamic responseBody = json.decode(response.body);

        UsersModel user =  UsersModel.fromJson(responseBody as Map<String, dynamic>);
        return user;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<LoginsResponseModel> postUserLogin(LoginsModel loginsModel) async {
    // TODO: implement postUserLogin
    final response = await client.post(
        Uri.parse(Url + '/login'),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json'
        },
        body : jsonEncode(loginsModel.toJson())
    );

    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        final dynamic responseBody = json.decode(response.body);

        LoginsResponseModel responseData = LoginsResponseModel.fromJson(responseBody as Map<String, dynamic>);
        return responseData;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }
}
