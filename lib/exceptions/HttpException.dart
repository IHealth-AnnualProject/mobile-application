import 'package:betsbi/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception {
  String cause;

  HttpException(this.cause) {
    print(cause);
    runApp(MaterialApp(home: LoginPage()));
  }
}
