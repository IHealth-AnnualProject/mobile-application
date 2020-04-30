import 'dart:convert';
import 'package:betsbi/exceptions/HttpException.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class TokenController {
  static Future<bool> checkTokenValidity() async {
    await SettingsManager.storage
        .read(key: "token")
        .then((token) => SettingsManager.currentToken = token);
    await SettingsManager.storage
        .read(key: "userId")
        .then((id) => SettingsManager.currentId = id);
    await SettingsManager.storage
        .read(key: "profileId")
        .then((profileID) => SettingsManager.currentProfileId = profileID);
    if (SettingsManager.currentToken != null) {
      try {
        final http.Response response = await http.get(
          SettingsManager.cfg.getString("apiUrl") + 'auth/is-token-valid',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + SettingsManager.currentToken,
          },
        );
        if (response.statusCode == 200) {
          return true;
        } else
          return false;
      } catch (e) {
        throw new HttpException("Error API Connection");
      }
    } else
      return false;
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
