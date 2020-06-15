import 'dart:convert';

import 'package:betsbi/model/response.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/service/SocketManager.dart';
import 'package:betsbi/view/FeelingsView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController {
  static DateTime feelingsParsed;

  static Widget redirectionLogin({bool isPsy = false}) {
    SocketManager.connectSocket();
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
    HttpManager httpManager =
        new HttpManager(path: 'auth/login', map: <String, String>{
      'username': username,
      'password': password,
    }, context: context);
    await httpManager.postWithoutAccessToken();
    await writePropertiesAfterLogin(httpManager).whenComplete(() => checkResponseAndShowItWithNoComingBack(httpManager, context, redirectionLogin()));
  }

  static checkResponseAndShowItWithNoComingBack(HttpManager httpManager, BuildContext context, Widget destination)  {
    if (httpManager.response.statusCode >= 100 && httpManager.response.statusCode < 400) {
            FlushBarMessage.goodMessage(content: SettingsManager.mapLanguage["ConnectSent"])
                .showFlushBarAndNavigatWithNoBack(context, destination);
    } else {
      FlushBarMessage.errorMessage(
          content: Response.fromJson(json.decode(httpManager.response.body)).content)
          .showFlushBar(context);
    }
  }

  static Future writePropertiesAfterLogin(HttpManager httpManager) async {
    await SettingsManager.storage
        .write(key: "userId", value: parseResponse(httpManager.response.body)["user"]["id"])
        .then((r) => SettingsManager.applicationProperties
            .setCurrentId(parseResponse(httpManager.response.body)["user"]["id"]));
    await SettingsManager.storage
        .write(
            key: "token",
            value: parseResponse(httpManager.response.body)["token"]["access_token"])
        .then((r) => SettingsManager.applicationProperties.setCurrentToken(
            parseResponse(httpManager.response.body)["token"]["access_token"]));
    await SettingsManager.storage
        .write(
            key: "isPsy",
            value: parseResponse(httpManager.response.body)["user"]["isPsy"].toString())
        .then((r) => SettingsManager.applicationProperties.setIsPsy(
            parseResponse(httpManager.response.body)["user"]["isPsy"].toString()));
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
