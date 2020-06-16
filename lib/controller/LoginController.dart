import 'dart:convert';

import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/service/SocketManager.dart';
import 'package:betsbi/view/FeelingsView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController {

  static Widget redirectionLogin({bool isPsy = false}) {
    SocketManager.connectSocket();
    DateTime feelingsParsed;
    if (SettingsManager.applicationProperties.isPsy().toLowerCase() ==
        'false') {
      if (SettingsManager.applicationProperties.getFeelingsDate().isNotEmpty) {
        final tomorrow = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
        feelingsParsed = DateTime.parse(
            SettingsManager.applicationProperties.getFeelingsDate());
        final dateToCompare = DateTime(
            feelingsParsed.year, feelingsParsed.month, feelingsParsed.day + 1);
        if (dateToCompare.isBefore(tomorrow)) {
          return FeelingsPage();
        } else {
          return HomePage(
            isPsy: false,
          );
        }
      } else
        return FeelingsPage();
    } else
      return HomePage(
        isPsy: true,
      );
  }

  static Future<void> login(
      String username, String password, BuildContext context) async {
    HttpManager httpManager = new HttpManager(
        path: 'auth/login',
        map: <String, String>{
          'username': username,
          'password': password,
        },
        context: context);
    await httpManager.postWithoutAccessToken();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      destination: redirectionLogin(),
      context:  context,
      onSuccess:  ()  => writePropertiesAfterLogin(httpManager),
      successMessage: SettingsManager.mapLanguage["ConnectSent"]
    );
    await responseManager.checkResponseAndShowItWithNoComingBack();
  }


  static Future writePropertiesAfterLogin(HttpManager httpManager) async {
    await SettingsManager.storage
        .write(
            key: "userId",
            value: parseResponse(httpManager.response.body)["user"]["id"])
        .then((r) => SettingsManager.applicationProperties.setCurrentId(
            parseResponse(httpManager.response.body)["user"]["id"]));
    await SettingsManager.storage
        .write(
            key: "token",
            value: parseResponse(httpManager.response.body)["token"]
                ["access_token"])
        .then((r) => SettingsManager.applicationProperties.setCurrentToken(
            parseResponse(httpManager.response.body)["token"]["access_token"]));
    await SettingsManager.storage
        .write(
            key: "isPsy",
            value: parseResponse(httpManager.response.body)["user"]["isPsy"]
                .toString())
        .then((r) => SettingsManager.applicationProperties.setIsPsy(
            parseResponse(httpManager.response.body)["user"]["isPsy"]
                .toString()));
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
