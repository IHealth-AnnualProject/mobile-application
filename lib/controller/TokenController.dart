import 'dart:convert';
import 'package:betsbi/model/Response.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TokenController {
  static Future<bool> checkTokenValidity(BuildContext context) async {
    await setTokenUserIdAndUserProfileIDFromStorageToSettingsManagerVariables();
    if (SettingsManager.applicationProperties.getCurrentToken() != null) {
      final http.Response response = await http.get(
        SettingsManager.cfg.getString("apiUrl") + 'auth/is-token-valid',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' +
              SettingsManager.applicationProperties.getCurrentToken(),
        },
      );
      return _checkResponseUserAndUpdateListIFOK(response, context);
    }
    return false;
  }

  static bool _checkResponseUserAndUpdateListIFOK(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      return true;
    } else {
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return false;
    }
  }

  static Future<void>
      setTokenUserIdAndUserProfileIDFromStorageToSettingsManagerVariables() async {
    await SettingsManager.storage.read(key: "token").then((token) =>
        SettingsManager.applicationProperties.setCurrentToken(token));
    await SettingsManager.storage
        .read(key: "userId")
        .then((id) => SettingsManager.applicationProperties.setCurrentId(id));
    await SettingsManager.storage
        .read(key: "isPsy")
        .then((isPsy) => SettingsManager.applicationProperties.setIsPsy(isPsy));
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
