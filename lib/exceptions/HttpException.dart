import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception {
  String cause;

  HttpException(this.cause) {
    print(cause);
    runApp(MaterialApp(home: LoginPage()));
  }

  HttpException.servorError(int errorCode){
    print("Internal Server Error : Error Code :" + errorCode.toString());
  }

  HttpException.sequestError(int errorCode){
    print("Request Error : Error Code :" + errorCode.toString());
  }
}
