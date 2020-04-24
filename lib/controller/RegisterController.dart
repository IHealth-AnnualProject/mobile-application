import 'dart:convert';

import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class RegisterController{

  static Future<bool> register(String username, String password, bool isPsy) async
  {
    final http.Response response = await http.post(SettingsManager.cfg.getString("apiUrl")+
      'auth/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
        'isPsy': isPsy
      }),
    );
    if (response.statusCode == 201) {
      return true;
    }
    else
      return false;
  }
}