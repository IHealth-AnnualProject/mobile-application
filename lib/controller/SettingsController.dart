import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsController {
  static void disconnect(BuildContext context) {
    SettingsManager.currentToken = "";
    SettingsManager.storage.write(key: "token", value: "").then(
          (r) => SettingsManager.storage.write(key: "isPsy", value: "").then(
                (_) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false),
              ),
        );
  }

}
