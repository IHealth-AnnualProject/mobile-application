import 'dart:convert';

import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class AccountController {
  static Future<UserProfile> getCurrentUserInformation(String userID) async {
    if (SettingsManager.currentToken != null &&
        SettingsManager.currentToken != "") {
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
      if (response.statusCode == 200) {
        return UserProfile.fromJson(json.decode(response.body));
      } else
        return UserProfile.defaultConstructor();
    } else
      return UserProfile.defaultConstructor();
  }

  static Future<Psychologist> getCurrentPsyInformation() async {
    if (SettingsManager.currentToken != null &&
        SettingsManager.currentToken != "") {
      final http.Response response = await http.get(
        SettingsManager.cfg.getString("apiUrl") +
            'psychologist/' +
            SettingsManager.currentId +
            '/user',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + SettingsManager.currentToken,
        },
      );
      if (response.statusCode == 200) {
        return Psychologist.fromJson(json.decode(response.body));
      } else
        return Psychologist.defaultConstructor();
    } else
      return Psychologist.defaultConstructor();
  }


  static Future<bool> updateCurrentUserInformation(
      {String firstname, String lastname, int age, String geolocation, String description}) async {
    if (SettingsManager.currentToken != null) {
      final http.Response response = await http.patch(
        SettingsManager.cfg.getString("apiUrl") + 'userProfile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + SettingsManager.currentToken,
        },
        body: jsonEncode(<String, dynamic>{
          "first_name": firstname,
          "last_name": lastname,
          "age": age,
          "description": description
        }),
      );
      print(response.statusCode.toString());
      if (response.statusCode == 204) {
        return true;
      } else
        return false;
    } else
      return false;
  }


}
