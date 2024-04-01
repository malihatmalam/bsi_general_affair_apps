
import 'package:bsi_general_affair_apps/data/datasource/api/user_remote_datasource.dart';
import 'package:bsi_general_affair_apps/data/models/users/logins_model.dart';
import 'package:bsi_general_affair_apps/data/models/users/logins_response_model.dart';
import 'package:bsi_general_affair_apps/data/models/users/users_model.dart';
import 'package:bsi_general_affair_apps/domain/failures/failures.dart';
import 'package:bsi_general_affair_apps/domain/repositories/users_repo.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/exceptions.dart';

class UsersRepoImpl implements UsersRepo {
  final UserApiRemoteDataSource userApiRemoteDataSource =
  UserApiRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<UsersModel>>> getUserAllData() async {
    // TODO: implement getUserAllData
    try{
      final result = await userApiRemoteDataSource.getUserAll();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, UsersModel>> getUserByUsernameData(String username) async {
    // TODO: implement getUserByUsernameData
    try{
      final result = await userApiRemoteDataSource.getUserByUsername(username);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, LoginsResponseModel>> postUserLoginData(LoginsModel loginsModel) async {
    // TODO: implement postUserLoginData
    try{
      final result = await userApiRemoteDataSource.postUserLogin(loginsModel);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }
}