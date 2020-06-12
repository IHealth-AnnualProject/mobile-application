import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterController {
  static Future<void> register(String username, String password, bool isPsy,
      BuildContext context) async {
    HttpManager httpManager = new HttpManager(
        path: 'auth/register',
        map: <String, dynamic>{
          'username': username,
          'password': password,
          'isPsy': isPsy
        }, context: context);
    await httpManager.postWithoutAccessToken();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      successMessage: SettingsManager.mapLanguage["RegisterSent"],
      context: context,
      destination: LoginPage(),
    );
    return responseManager.checkResponseAndShowIt();
  }
}
