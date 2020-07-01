import 'dart:async';
import 'dart:convert';
import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TokenController {
  static Future<bool> checkTokenValidity(BuildContext context) async {
    await setTokenUserIdAndUserProfileIDFromStorageToSettingsManagerVariables();
    if (SettingsManager.applicationProperties.getCurrentToken() != null) {
      HttpManager httpManager =
      new HttpManager(path: 'auth/is-token-valid', context: context);
      await httpManager.get();
      ResponseManager responseManager = new ResponseManager(response: httpManager.response,context: context,);
      return responseManager.checkResponseReturnTrueIfOkAndFalseIfNotOk();
    }
    return false;
  }

  static redirectToLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }


  static Future<void>
      setTokenUserIdAndUserProfileIDFromStorageToSettingsManagerVariables() async {
    await SettingsManager.storage.read(key: "token").then((token) =>
        SettingsManager.applicationProperties.setCurrentToken(token));
    await SettingsManager.storage
        .read(key: "userId")
        .then((id) => SettingsManager.applicationProperties.setCurrentId(id));
    await SettingsManager.storage
        .read(key: "isPsy")
        .then((isPsy) => SettingsManager.applicationProperties.setIsPsy(isPsy));
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
