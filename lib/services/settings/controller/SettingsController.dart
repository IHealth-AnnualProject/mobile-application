import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/introduction/view/IntroductionView.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:betsbi/services/settings/view/SettingsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsController {
  static void disconnect(BuildContext context) {
    SettingsManager.applicationProperties.setCurrentToken("");
    HistoricalManager.historical = new List<Widget>();
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

  static void reloadIntroductionPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => IntroductionPage(destination: SettingsPage(),),),
            (Route<dynamic> route) => false);
  }

}
