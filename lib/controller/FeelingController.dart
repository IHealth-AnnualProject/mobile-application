import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingController {

  static void redirectionFeelingToHomePage(BuildContext context) {
    SettingsManager.storage
        .write(key: "feelingsDate", value: DateTime.now().toString())
        .then((r) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }
}
