import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

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

  static Widget buildError(BuildContext context, FlutterErrorDetails error) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Error appeared.", style: Theme.of(context).textTheme.title),
          CountDown(
            seconds: 2,
            onTimer: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
