
import 'package:bsi_general_affair_apps/data/datasource/api/proposal_remote_datasource.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_create_model.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_model.dart';
import 'package:bsi_general_affair_apps/data/models/proposals/proposals_update_model.dart';
import 'package:bsi_general_affair_apps/domain/failures/failures.dart';
import 'package:bsi_general_affair_apps/domain/repositories/proposals_repo.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/exceptions.dart';

class ProposalsRepoImpl implements ProposalsRepo{
  final ProposalApiRemoteDataSource proposalApiRemoteDataSource =
  ProposalApiRemoteDataSourceImpl();

  @override
  Future<Either<Failure, String>> deleteProposalCancelData(String proposalToken) async {
    // TODO: implement deleteProposalCancelData
    try{
      final result = await proposalApiRemoteDataSource.deleteProposalCancel(proposalToken);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, ProposalsModel>> getProposalDetailData(String proposalToken) async {
    // TODO: implement getProposalDetailData
    try{
      final result = await proposalApiRemoteDataSource.getProposalDetail(proposalToken);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProposalsModel>>> getProposalHistoryData(String employeeNumber, String typeProposal) async {
    // TODO: implement getProposalHistoryData
    try{
      final result = await proposalApiRemoteDataSource.getProposalHistory(employeeNumber, typeProposal);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProposalsModel>>> getProposalWaitingData(String employeeNumber) async {
    // TODO: implement getProposalWaitingData
    try{
      final result = await proposalApiRemoteDataSource.getProposalWaiting(employeeNumber);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postProposalCreateData(ProposalsCreateModel proposalsCreateModel) async {
    // TODO: implement postProposalCreateData
    try{
      final result = await proposalApiRemoteDataSource.postProposalCreate(proposalsCreateModel);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postProposalUpdateData(ProposalsUpdateModel proposalsUpdateModel) async {
    // TODO: implement postProposalUpdateData
    try{
      final result = await proposalApiRemoteDataSource.postProposalUpdate(proposalsUpdateModel);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<ProposalsModel> getProposalDetailDataEdit(String proposalToken) async {
    // TODO: implement getProposalDetailDataEdit
    try{
      final result = await proposalApiRemoteDataSource.getProposalDetail(proposalToken);
      return result;
    } catch (e) {
      print(e);
      throw ArgumentError(e);
    }
  }
}