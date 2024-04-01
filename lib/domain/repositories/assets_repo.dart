import '../../data/models/assets/assets_model.dart';
import '../failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AssetsRepo{
  Future<Either<Failure,AssetsModel>> getAssetDetailData(String numberAsset);
  Future<Either<Failure,List<AssetsModel>>> getAssetByEmployeeNumberData(String employeeNumber);
}