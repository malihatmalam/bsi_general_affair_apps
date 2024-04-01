

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/users/logins_model.dart';
import '../../data/models/users/users_model.dart';
import '../../data/repositories/users_repo_impl.dart';
import '../../presentation/core/services/auth_services.dart';
import '../failures/failures.dart';

class UsersUseCases {
  final userRepo = UsersRepoImpl();
  bool? _isAuthenticating;

  Future<Either<Failure, List<UsersModel>>> getUserAllData() {
    // TODO: implement getUserAllData
    return userRepo.getUserAllData();
  }

  Future<Either<Failure, UsersModel>> getUserByUsernameData(String username) {
    // TODO: implement getUserByUsernameData
    return userRepo.getUserByUsernameData(username);
  }

  Future<void> postUserLoginData({required LoginsModel loginsModel, required BuildContext context}) async {
    // TODO: implement postUserLoginData
    _isAuthenticating = Provider.of<AuthService>(context, listen: false).getIsAuthenticating();
    print(_isAuthenticating);
    Provider.of<AuthService>(context, listen: false).changeIsAuthenticating();

    var box = Hive.box('userdata');
    var failureOrUser = await userRepo.postUserLoginData(loginsModel);
    failureOrUser.fold(
            (failure) {
              _isAuthenticating = Provider.of<AuthService>(context, listen: false).getIsAuthenticating();
              print(_isAuthenticating);
              Provider.of<AuthService>(context, listen: false).changeIsAuthenticating();
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Authentication failed.'),
                ),
              );
            },
            (users) {
              DateTime currentTime = DateTime.now();
              DateTime futureTime = currentTime.add( const Duration(hours: 1));
              Map<String, dynamic> decodedToken = JwtDecoder.decode(users.token!);

              box.put('username', users.username);
              box.put('employeeNumber', decodedToken['unique_name']);
              box.put('token', users.token);
              box.put('session_timeout', futureTime.toString());
              box.put('role', decodedToken['role']);

              Provider.of<AuthService>(context, listen: false).setEnteredUsername('');
              Provider.of<AuthService>(context, listen: false).setEnteredPassword('');
              Provider.of<AuthService>(context, listen: false).changeIsAuthenticating();
              _isAuthenticating = Provider.of<AuthService>(context, listen: false).getIsAuthenticating();
              print(_isAuthenticating);
              print("username : ${box.get('username')}, "
                  "eployee number : ${box.get('employeeNumber')}, "
                  "token : ${box.get('token')}, "
                  "session_timeout : ${box.get('session_timeout')}"
                  "role : ${box.get('role')}");
              context.go('/');
            }
            );
  }

  Future<bool> signOutApplication() async {
    try{
      var box = Hive.box('userdata');
      box.put('username', null);
      box.put('employeeNumber', null);
      box.put('token', null);
      box.put('session_timeout', null);
      return true;
    }catch (e){
      return false;
    }
  }

  bool checkTime(DateTime future) {
    // Mendapatkan waktu saat ini
    DateTime now = DateTime.now();
    // DateTime nowMani = now.add(Duration(minutes: 57));

    // Membandingkan waktu saat ini dengan waktu di masa depan
    return now.isAfter(future);
    // return nowMani.isAfter(future);
  }

  Future<void> checkSession({required BuildContext context}) async{
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var box = Hive.box('userdata');
      DateTime? futureTime;
      if (box.get('session_timeout', defaultValue: null) != null) {
        futureTime = DateTime.parse(box.get('session_timeout'));
        print(futureTime);
      } else {
        futureTime = DateTime.parse("3000-01-01");
        print("Gagal");
      }

      if (box.get('token', defaultValue: null) == null || checkTime(futureTime)) {
        print("coba");
        context.go('/login');
      }
    });
  }
}