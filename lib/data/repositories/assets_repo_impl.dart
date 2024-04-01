
import 'package:bsi_general_affair_apps/data/datasource/api/asset_remote_datasource.dart';
import 'package:bsi_general_affair_apps/data/models/assets/assets_model.dart';
import 'package:bsi_general_affair_apps/domain/failures/failures.dart';
import 'package:bsi_general_affair_apps/domain/repositories/assets_repo.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/exceptions.dart';

class AssetsRepoImpl implements AssetsRepo{
  final AssetApiRemoteDataSource assetApiRemoteDataSource =
  AssetApiRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<AssetsModel>>> getAssetByEmployeeNumberData(String employeeNumber) async {
    // TODO: implement getAssetByEmployeeNumberData
    try{
      final result = await assetApiRemoteDataSource.getAssetByEmployeeNumber(employeeNumber);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, AssetsModel>> getAssetDetailData(String numberAsset) async {
    // TODO: implement getAssetDetailData
    try{
      final result = await assetApiRemoteDataSource.getAssetDetail(numberAsset);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }
}