import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/FeelingsView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginController {
  static String feelingsDate;
  static DateTime feelingsParsed;

  static void redirection(BuildContext context) {
    feelingsDate = SettingsManager.cfg.getString("feelingsDate");
    if (feelingsDate.isNotEmpty) {
      feelingsParsed = DateTime.parse(feelingsDate);
      if (feelingsParsed.isBefore(DateTime.now())) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FeelingsPage()));
      }
      else{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
    else
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FeelingsPage()));
  }
}
