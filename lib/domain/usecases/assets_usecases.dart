

import 'package:bsi_general_affair_apps/data/repositories/assets_repo_impl.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/assets/assets_model.dart';
import '../failures/failures.dart';

class AssetsUseCases {
  final assetRepo = AssetsRepoImpl();

  Future<Either<Failure,AssetsModel>> getAssetDetail(String numberAsset) {
    // TODO: implement getAssetDetail
    return assetRepo.getAssetDetailData(numberAsset);
  }

  Future<Either<Failure,List<AssetsModel>>> getAssetByEmployeeNumber(String employeeNumber) {
    // TODO: implement getAssetByEmployeeNumber
    return assetRepo.getAssetByEmployeeNumberData(employeeNumber);
  }

}