import 'dart:convert';

import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/manager/SocketManager.dart';
import 'package:betsbi/services/feeling/view/FeelingsView.dart';
import 'package:betsbi/services/global/model/response.dart';
import 'package:betsbi/services/home/view/HomeView.dart';
import 'package:betsbi/tools/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController {
  static Future<Widget> redirectionLogin({bool isPsy = false}) async {
    SocketManager.connectSocket();
    SettingsManager.applicationProperties.setFeelingsDate(
        await SettingsManager.storage.read(key: "feelingsDate"));
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
      {@required String username,
      @required String password,
      @required BuildContext context}) async {
    HttpManager httpManager = new HttpManager(
        path: 'auth/login',
        map: <String, String>{
          'username': username,
          'password': password,
        },
        context: context);
    await httpManager.postWithoutAccessToken();
    await checkResponseAndShowItWithNoComingBack(
        httpManager: httpManager, context: context);
  }

  static Future<void> checkResponseAndShowItWithNoComingBack(
      {@required HttpManager httpManager,
      @required BuildContext context}) async {
    if (httpManager.response.statusCode >= 100 &&
        httpManager.response.statusCode < 400) {
      await writePropertiesAfterLogin(httpManager);
      FlushBarMessage.goodMessage(
              content: SettingsManager.mapLanguage["ConnectSent"])
          .showFlushBarAndNavigatWithNoBack(context, await redirectionLogin());
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(httpManager.response.body))
                  .content)
          .showFlushBar(context);
    }
  }

  static Future<void> writePropertiesAfterLogin(HttpManager httpManager) async {
    SettingsManager.applicationProperties
        .setCurrentId(parseResponse(httpManager.response.body)["user"]["id"]);
    SettingsManager.applicationProperties.setCurrentToken(
        parseResponse(httpManager.response.body)["token"]["access_token"]);
    SettingsManager.applicationProperties.setIsPsy(
        parseResponse(httpManager.response.body)["user"]["isPsy"].toString());
    await SettingsManager.storage.write(
        key: "userId",
        value: parseResponse(httpManager.response.body)["user"]["id"]);
    await SettingsManager.storage.write(
        key: "token",
        value: parseResponse(httpManager.response.body)["token"]
            ["access_token"]);
    await SettingsManager.storage.write(
        key: "isPsy",
        value: parseResponse(httpManager.response.body)["user"]["isPsy"]
            .toString());
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }

  static Future<void> resetPassword(
      {@required BuildContext context, @required String userName}) async {
    HttpManager httpManager = new HttpManager(
        path: 'auth/resetPassword',
        map: <String, String>{'username': userName},
        context: context);
    await httpManager.postWithoutAccessToken();
    ResponseManager responseManager =
        new ResponseManager(response: httpManager.response, context: context);
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(
        successMessage: SettingsManager.mapLanguage["EnterMail"]);
  }
}
