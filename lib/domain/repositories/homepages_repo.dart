

import 'package:dartz/dartz.dart';

import '../../data/models/homepages/homepages_model.dart';
import '../failures/failures.dart';

abstract class HomepagesRepo{
  Future<Either<Failure, HomepagesModel>> getHomepageData(String employeeNumber);
}