import 'package:betsbi/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception {
  String cause;

  HttpException(this.cause) {
    print(cause);
    runApp(MaterialApp(home: LoginPage()));
  }

  HttpException.ServorError(int errorCode){
    print("Internal Server Error : Error Code :" + errorCode.toString());
  }

  HttpException.RequestError(int errorCode){
    print("Request Error : Error Code :" + errorCode.toString());
  }
}
