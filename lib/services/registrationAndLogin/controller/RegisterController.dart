import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterController {
  static Future<void> register(
      {@required String username,
      @required String password,
      @required bool isPsy,
      @required BuildContext context,
      @required String email}) async {
    HttpManager httpManager = new HttpManager(
        path: 'auth/register',
        map: <String, dynamic>{
          'username': username,
          'password': password,
          'isPsy': isPsy,
          'email': email
        },
        context: context);
    await httpManager.postWithoutAccessToken();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager
        .checkResponseAndShowWithFlushBarMessageTheAnswerThenGoToDestination(
            destination: LoginPage(),
            successMessage: isPsy
                ? SettingsManager.mapLanguage["RegisterSentAsPsy"]
                : SettingsManager.mapLanguage["RegisterSent"]);
  }
}
