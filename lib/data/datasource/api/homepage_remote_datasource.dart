
import 'dart:convert';

import 'package:bsi_general_affair_apps/data/models/homepages/homepages_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/exceptions.dart';

abstract class HomepageApiRemoteDataSource{
  Future<HomepagesModel> getHomepage(String employeeNumber);
}

class HomepageApiRemoteDataSourceImpl implements HomepageApiRemoteDataSource{
  final String Url = "https://app.actualsolusi.com/bsi/BSIGeneralAffair/api/v1/Homepage";
  final client = http.Client();
  var box = Hive.box('userdata');

  @override
  Future<HomepagesModel> getHomepage(String employeeNumber) async {
    // TODO: implement getHomepageData
    final response = await client.get(
        Uri.parse(Url + '/${employeeNumber}'),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
    );try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        final dynamic responseBody = json.decode(response.body);

        HomepagesModel homepage = HomepagesModel.fromJson(responseBody as Map<String, dynamic>);
        return homepage;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }
}