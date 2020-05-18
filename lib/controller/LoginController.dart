import 'dart:convert';

import 'package:betsbi/model/response.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/service/SocketManager.dart';
import 'package:betsbi/view/FeelingsView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static DateTime feelingsParsed;

  static Widget redirectionLogin({bool isPsy = false}) {
    SocketManager.connectSocket();
    if (SettingsManager.isPsy.toLowerCase() == 'false') {
      if (SettingsManager.feelingsDate.isNotEmpty) {
        final tomorrow = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
        feelingsParsed = DateTime.parse(SettingsManager.feelingsDate);
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
    final http.Response response = await http.post(
      SettingsManager.cfg.getString("apiUrl") + 'auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    await checkResponseAndRedirectifOK(response, context);
  }

  static Future writePropertiesAfterLogin(http.Response response) async {
    await SettingsManager.storage
        .write(key: "userId", value: parseResponse(response.body)["user"]["id"])
        .then((r) => SettingsManager.currentId =
            parseResponse(response.body)["user"]["id"]);
    await SettingsManager.storage
        .write(
            key: "token",
            value: parseResponse(response.body)["token"]["access_token"])
        .then((r) => SettingsManager.currentToken =
            parseResponse(response.body)["token"]["access_token"]);
    await SettingsManager.storage
        .write(
            key: "isPsy",
            value: parseResponse(response.body)["user"]["isPsy"].toString())
        .then((r) => SettingsManager.isPsy =
            parseResponse(response.body)["user"]["isPsy"].toString());
  }

  static Future<void> checkResponseAndRedirectifOK(
      http.Response response, BuildContext context) async {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      await writePropertiesAfterLogin(response);
      FlushBarMessage.goodMessage(
              content: SettingsManager.mapLanguage["ConnectSent"] != null
                  ? SettingsManager.mapLanguage["ConnectSent"]
                  : "")
          .showFlushBarAndNavigateAndRemove(
              context, LoginController.redirectionLogin());
    } else
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
