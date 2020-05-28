import 'dart:convert';

import 'package:betsbi/model/Response.dart';
import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SearchBarController {
  static Future<List<User>> getAllProfile(BuildContext context) async {
    var users = new List<User>();
    final http.Response responseProfileUSer = await http.get(
      SettingsManager.cfg.getString("apiUrl") + 'userProfile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
    );
    _checkResponseUserAndUpdateListIFOK(responseProfileUSer, users, context);
    // remove psy from list if you're already a psy
    final http.Response responseProfilePsy = await http.get(
      SettingsManager.cfg.getString("apiUrl") + 'psychologist',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
    );
    _checkResponsePSYAndUpdateListIFOK(responseProfilePsy, users, context);
    return users;
  }

  static void _checkResponseUserAndUpdateListIFOK(
      http.Response response, List<User> users, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      Iterable list = json.decode(response.body);
      users.addAll(list.map((model) => UserProfile.fromJson(model)).toList());
    } else
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
  }

  static void _checkResponsePSYAndUpdateListIFOK(
      http.Response response, List<User> users, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      Iterable list = json.decode(response.body);
      list = json.decode(response.body);
      users.addAll(
          list.map((model) => Psychologist.fromJsonForSearch(model)).toList());
      users.removeWhere((user) => user.profileId == SettingsManager.applicationProperties.getCurrentToken());
    } else
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
  }
}
