
import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterController {
  static Future<void> register(String username, String password, bool isPsy,
      BuildContext context, String email) async {
    HttpManager httpManager = new HttpManager(
        path: 'auth/register',
        map: <String, dynamic>{
          'username': username,
          'password': password,
          'isPsy': isPsy,
          'email' : email
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
