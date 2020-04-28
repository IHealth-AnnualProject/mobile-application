import 'dart:convert';

import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class AccountController {

  static Future<UserProfile> getCurrentAccountInformation() async {
    String currentToken;
    await SettingsManager.storage.read(key: "token").then((token) =>
    currentToken = token
    );
    if (currentToken != null) {
      final http.Response response = await http.get(
        SettingsManager.cfg.getString("apiUrl") + 'userProfile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + currentToken,
        },
      );
      if (response.statusCode == 200) {
        return UserProfile.fromJson(json.decode(response.body));
      } else
        return UserProfile.defaultConstructor();
    }
    else
      return UserProfile.defaultConstructor();
  }

  static Future<bool> updateCurrentUserInformation({String firstname, String lastname, int age, String geolocation}) async {
    String currentToken;
    await SettingsManager.storage.read(key: "token").then((token) =>
    currentToken = token
    );
    if (currentToken != null) {
      final http.Response response = await http.patch(
        SettingsManager.cfg.getString("apiUrl") + 'userProfile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + currentToken,
        },
        body: jsonEncode(<String, dynamic>{
          "first_name": firstname,
          "last_name": lastname,
          "age": age,
          "geolocation": geolocation
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    }
    else
      return false;
  }

}