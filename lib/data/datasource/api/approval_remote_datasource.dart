

import 'dart:convert';

import 'package:bsi_general_affair_apps/data/models/approvals/approval_posts_model.dart';
import 'package:bsi_general_affair_apps/data/models/approvals/approvals_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/exceptions.dart';

abstract class ApprovalApiRemoteDataSource{
  Future<List<ApprovalsModel>> getApprovalByProposalToken(String proposalToken);
  Future<String> postApproval(ApprovalPostsModel approvalPostsModel);
}

class ApprovalApiRemoteDataSourceImpl implements ApprovalApiRemoteDataSource{
  final String Url = "https://app.actualsolusi.com/bsi/BSIGeneralAffair/api/v1/Approval";
  final client = http.Client();
  var box = Hive.box('userdata');

  @override
  Future<List<ApprovalsModel>> getApprovalByProposalToken(String proposalToken) async {
    // TODO: implement getApprovalByProposalToken
    final response = await client.get(
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
        final List<dynamic> responseBody = json.decode(response.body);

        List<ApprovalsModel> approvals = (responseBody)
            .map((approval) => ApprovalsModel.fromJson(approval as Map<String, dynamic>))
            .toList();
        return approvals;
      }
    } catch (error){
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }

  @override
  Future<String> postApproval(ApprovalPostsModel approvalPostsModel) async {
    // TODO: implement postApproval
    print(jsonEncode(approvalPostsModel.toJson()));
    final response = await client.post(
        Uri.parse(Url),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: jsonEncode(approvalPostsModel.toJson())
    );

    try {
      if (response.statusCode != 200) {
        print('Server error : ${response.body}');
        print('Status error : ${response.statusCode}');
        throw ServerException();
      } else {
        String responseBody = response.body;
        return responseBody;
      }
    } catch (error) {
      print('Error making HTTP request: $error');
      throw ArgumentError('Error : ${error}');
    }
  }
}

