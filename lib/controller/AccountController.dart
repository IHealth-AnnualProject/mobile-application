import 'dart:convert';

import 'package:betsbi/model/Response.dart';
import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AccountController {
  static Future<UserProfile> getCurrentUserInformation(
      String userID, BuildContext context) async {
    final http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") +
          'userProfile/' +
          userID +
          '/user',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
    );
    return _checkResponseAndGetUserInformationIfOk(response, context);
  }

  static UserProfile _checkResponseAndGetUserInformationIfOk(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return UserProfile.defaultConstructor();
    }
  }

  static Future<Psychologist> getCurrentPsyInformation(
      String psyId, BuildContext context) async {
    final http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") +
          'psychologist/' +
          psyId +
          '/user',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
    );
    return _checkResponseAndGetPsyInformationIfOk(response, context);
  }

  static Psychologist _checkResponseAndGetPsyInformationIfOk(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      return Psychologist.fromJson(json.decode(response.body));
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return Psychologist.defaultConstructor();
    }
  }

  static Future<bool> updateCurrentUserInformation(
      {String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      BuildContext context}) async {
    final http.Response response = await http.patch(
      SettingsManager.cfg.getString("apiUrl") + 'userProfile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
      body: jsonEncode(<String, dynamic>{
        "birthdate": birthdate,
        "description": description
      }),
    );
    return _checkResponseUpdateAndNavigateIfOk(
        response,
        context,
        AccountPage(
          userId: profileId,
          isPsy: isPsy,
        ));
  }

  static Future<bool> updateCurrentPsyInformation(
      {String firstname,
      String lastname,
      String birthdate,
      String geolocation,
      String description,
      String profileId,
      bool isPsy,
      BuildContext context}) async {
    final http.Response response = await http.patch(
      SettingsManager.cfg.getString("apiUrl") + 'psychologist',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
      body: jsonEncode(<String, dynamic>{
        "first_name": firstname,
        "last_name": lastname,
        "birthdate": birthdate,
        "description": description
      }),
    );
    return _checkResponseUpdateAndNavigateIfOk(
        response,
        context,
        AccountPage(
          userId: profileId,
          isPsy: isPsy,
        ));
  }

  static bool _checkResponseUpdateAndNavigateIfOk(
      http.Response response, BuildContext context, Widget destination) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      FlushBarMessage.goodMessage(
              content:
                  SettingsManager.mapLanguage["UpdateUserInformation"] != null
                      ? SettingsManager.mapLanguage["UpdateUserInformation"]
                      : "")
          .showFlushBarAndNavigateAndRemove(context, destination);
      return true;
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return false;
    }
  }
}
