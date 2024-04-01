

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AuthService extends ChangeNotifier{
  // bool _isLogin = true;
  bool _isAuthenticating = false;
  bool _isApproving = false;
  String _enteredPassword = "";
  String _enteredUsername = "";

  // void changeIsLogin(){
  //   _isLogin = !_isLogin;
  //   notifyListeners();
  // }

  void changeIsAuthenticating(){
    _isAuthenticating = !_isAuthenticating;
    notifyListeners();
  }

  void changeIsApproving(){
    _isApproving = !_isApproving;
    notifyListeners();
  }

  void setEnteredPassword(password){
    _enteredPassword = password;
    notifyListeners();
  }

  void setEnteredUsername(username){
    _enteredUsername = username;
    notifyListeners();
  }


  // bool getIsLogin() => _isLogin;

  bool getIsAuthenticating() => _isAuthenticating;

  bool getIsApproving() => _isApproving;

  String? getEnteredUsername() => _enteredUsername;

  String? getEnteredPassword() => _enteredPassword;
}