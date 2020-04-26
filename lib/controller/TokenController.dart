import 'dart:convert';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class TokenController{


  static Future<bool> checkTokenValidity() async {
    String currentToken;
    await SettingsManager.storage.read(key: "token").then((token) =>
      currentToken = token
    );
    if (currentToken != null) {
      final http.Response response = await http.get(
        SettingsManager.cfg.getString("apiUrl") + 'auth/is-token-valid',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + currentToken,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    }
    else
      return false;
  }

  static Map<String, dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}