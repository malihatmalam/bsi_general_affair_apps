
import 'package:dartz/dartz.dart';

import '../../data/models/users/logins_model.dart';
import '../../data/models/users/logins_response_model.dart';
import '../../data/models/users/users_model.dart';
import '../failures/failures.dart';

abstract class UsersRepo{
  Future<Either<Failure, List<UsersModel>>> getUserAllData();
  Future<Either<Failure, UsersModel>> getUserByUsernameData(String username);
  Future<Either<Failure, LoginsResponseModel>> postUserLoginData(LoginsModel loginsModel);
}