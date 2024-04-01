import 'package:bsi_general_affair_apps/data/repositories/homepages_repo_impl.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/homepages/homepages_model.dart';
import '../failures/failures.dart';

class HomepagesUseCases {
  final homepageRepo = HomepagesRepoImpl();

  Future<Either<Failure, HomepagesModel>> getHomepageData(String employeeNumber) {
    // TODO: implement getHomepageData
    return homepageRepo.getHomepageData(employeeNumber);
  }
}