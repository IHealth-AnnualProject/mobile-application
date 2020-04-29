import 'dart:convert';

import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeelingController {
  static void redirectionFeelingToHomePage(BuildContext context) {
    SettingsManager.storage
        .write(key: "feelingsDate", value: DateTime.now().toString())
        .then((r) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  static Future<bool> sendFeelings(int value) async {
    final http.Response response = await http.post(
      SettingsManager.cfg.getString("apiUrl") + 'userProfile/moral-stats',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
      body: jsonEncode(<String, int>{
        'value': value,
      }),
    );
    if (response.statusCode == 201) {
      return true;
    } else
      return false;
  }
}
