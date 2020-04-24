import 'dart:convert';

import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/FeelingsView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static String feelingsDate;
  static DateTime feelingsParsed;

  static void redirection(BuildContext context) {
    feelingsDate = SettingsManager.cfg.getString("feelingsDate");
    if (feelingsDate.isNotEmpty) {
      feelingsParsed = DateTime.parse(feelingsDate);
      if (feelingsParsed.isBefore(DateTime.now())) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeelingsPage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FeelingsPage()));
  }

  static Future<bool> login(String username, String password) async {
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
    if (response.statusCode == 201) {
      await SettingsManager.storage.write(key: "token", value: parseResponse(response.body)["token"]["access_token"]);
      return true;
    } else
      return false;
  }

    static Map<String,dynamic> parseResponse(String response) {
    return jsonDecode(response);
  }
}
