

import 'package:bsi_general_affair_apps/data/datasource/api/homepage_remote_datasource.dart';
import 'package:bsi_general_affair_apps/data/models/homepages/homepages_model.dart';
import 'package:bsi_general_affair_apps/domain/failures/failures.dart';
import 'package:bsi_general_affair_apps/domain/repositories/homepages_repo.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/exceptions.dart';

class HomepagesRepoImpl implements HomepagesRepo{
  final HomepageApiRemoteDataSource homepageApiRemoteDataSource =
  HomepageApiRemoteDataSourceImpl();

  @override
  Future<Either<Failure, HomepagesModel>> getHomepageData(String employeeNumber) async {
    // TODO: implement getHomepageData
    try{
      final result = await homepageApiRemoteDataSource.getHomepage(employeeNumber);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }
}