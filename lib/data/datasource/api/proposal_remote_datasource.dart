
import 'dart:convert';

import 'package:bsi_general_affair_apps/data/exceptions/exceptions.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_create_model.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_model.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_update_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

abstract class ProposalApiRemoteDataSource{
  Future<List<ProposalsModel>> getProposalWaiting(String employeeNumber);
  Future<List<ProposalsModel>> getProposalHistory(String employeeNumber, String typeProposal);
  Future<ProposalsModel> getProposalDetail(String proposalToken);
  Future<String> postProposalUpdate(ProposalsUpdateModel proposalsUpdateModel);
  Future<String> postProposalCreate(ProposalsCreateModel proposalsCreateModel);
  Future<String> deleteProposalCancel(String proposalToken);
}

class ProposalApiRemoteDataSourceImpl implements ProposalApiRemoteDataSource{
  final String Url = "https://app.actualsolusi.com/bsi/BSIGeneralAffair/api/v1/Proposal";
  final client = http.Client();
  var box = Hive.box('userdata');

  @override
  Future<List<ProposalsModel>> getProposalWaiting(String employeeNumber) async {
    final map = <String, dynamic>{};
    map['emplyeeNumber'] = employeeNumber;

    final response = await client.post(
        Uri.parse(Url + '/waiting'),
        headers: {
          'accept' : '*/*',
          // 'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body : map
    );
    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        final List<dynamic> responseBody = json.decode(response.body);

        List<ProposalsModel> proposals = (responseBody)
            .map((proposal) => ProposalsModel.fromJson(proposal as Map<String, dynamic>))
            .toList();
        return proposals;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<List<ProposalsModel>> getProposalHistory(String employeeNumber, String typeProposal) async {
    final map = <String, dynamic>{};
    map['emplyeeNumber'] = employeeNumber;
    map['typeProposal'] = typeProposal;

    final response = await client.post(
        Uri.parse(Url + '/history'),
        headers: {
          'accept' : '*/*',
          // 'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body : map
    );
    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        final List<dynamic> responseBody = json.decode(response.body);

        List<ProposalsModel> proposals = (responseBody)
            .map((proposal) => ProposalsModel.fromJson(proposal as Map<String, dynamic>))
            .toList();
        return proposals;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<ProposalsModel> getProposalDetail(String proposalToken) async {
    // TODO: implement getProposalDetail
    final response = await client.get(
        Uri.parse(Url + '/${proposalToken}'),
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

        ProposalsModel proposal =  ProposalsModel.fromJson(responseBody as Map<String, dynamic>);
        return proposal;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<String> postProposalUpdate(ProposalsUpdateModel proposalsUpdateModel) async {
    // TODO: implement postProposalUpdate
    print(proposalsUpdateModel.toJson());

    final response = await client.put(
      Uri.parse(Url + "/${proposalsUpdateModel.proposalToken}"),
      headers: {
        'accept' : '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.get('token')}'
      },
      body: jsonEncode(proposalsUpdateModel.toJson())
    );

    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        print('${response.statusCode}');
        throw ServerException();
      } else {
        String responseBody = response.body;
        return responseBody;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<String> deleteProposalCancel(String proposalToken) async {
    // TODO: implement deleteProposalCancel
    final response = await client.delete(
      Uri.parse(Url + "/${proposalToken}"),
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
        String responseBody = response.body;
        return responseBody;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<String> postProposalCreate(ProposalsCreateModel proposalsCreateModel) async {
    // TODO: implement postProposalCreate
    final response = await client.post(
        Uri.parse(Url),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: jsonEncode(proposalsCreateModel.toJson())
    );

    try{
      if (response.statusCode != 200){
        print('Server error : ${response.body}');
        throw ServerException();
      } else {
        String responseBody = response.body;
        return responseBody;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }
}