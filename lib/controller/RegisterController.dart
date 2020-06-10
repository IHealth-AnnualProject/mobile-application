import 'dart:convert';
import 'package:betsbi/model/response.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/LoginView.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterController {
  static Future<void> register(
      String username, String password, bool isPsy, BuildContext context) async {
    HttpManager httpManager =
    new HttpManager(path: 'auth/register', map: <String, dynamic>{
      'username': username,
      'password': password,
      'isPsy': isPsy
    });
    await httpManager.postWithoutAccessToken();
    checkResponseAndDO(httpManager.response, context);
  }

  static void checkResponseAndDO(http.Response response, BuildContext context) {
    if(response.statusCode >=  100 && response.statusCode < 400) {
      FlushBarMessage.goodMessage(content : SettingsManager.mapLanguage["RegisterSent"] !=
          null
          ? SettingsManager
          .mapLanguage["RegisterSent"]
          : "")
          .showFlushBarAndNavigateAndRemove(context, LoginPage());
    }
    else
      FlushBarMessage.errorMessage(
          content : Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
  }
}
