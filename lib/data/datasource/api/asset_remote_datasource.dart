
import 'dart:convert';

import 'package:bsi_general_affair_apps/data/models/assets/assets_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/exceptions.dart';

abstract class AssetApiRemoteDataSource{
  Future<AssetsModel> getAssetDetail(String numberAsset);
  Future<List<AssetsModel>> getAssetByEmployeeNumber(String employeeNumber);
}

class AssetApiRemoteDataSourceImpl implements AssetApiRemoteDataSource{
  final String Url = "https://app.actualsolusi.com/bsi/BSIGeneralAffair/api/v1/Asset";
  final client = http.Client();
  var box = Hive.box('userdata');

  @override
  Future<List<AssetsModel>> getAssetByEmployeeNumber(String employeeNumber) async {
    // TODO: implement getAssetByEmployeeNumber
    print(employeeNumber);
    final map = <String, dynamic>{};
    map['employeeNumber'] = employeeNumber;
    // Map<String, dynamic> requestBody = {
    //   map['employeeNumber'] : employeeNumber
    // };
    // String requestBodyJson = jsonEncode(requestBody);
    // print(requestBodyJson);

    final response = await client.post(
        Uri.parse(Url + "/myAsset"),
        headers: {
          'accept' : '*/*',
          // 'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: map
        // body: requestBodyJson
    );
    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        final List<dynamic> responseBody = json.decode(response.body);

        List<AssetsModel> assets = (responseBody)
            .map((asset) => AssetsModel.fromJson(asset as Map<String, dynamic>))
            .toList();
        return assets;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<AssetsModel> getAssetDetail(String numberAsset) async {
    // TODO: implement getAssetDetail
    final response = await client.get(
        Uri.parse(Url + "/detail/${numberAsset}"),
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
        final dynamic responseBody = json.decode(response.body);

        AssetsModel asset = AssetsModel.fromJson(responseBody as Map<String, dynamic>);
        return asset;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }
}