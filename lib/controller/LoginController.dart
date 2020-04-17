import 'package:betsbi/home.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feelings.dart';

class LoginController {
  static String feelingsDate;
  static DateTime feelingsParsed;

  static void redirection(BuildContext context) {
    feelingsDate = SettingsManager.cfg.getString("feelingsDate");
    if (feelingsDate.isNotEmpty) {
      feelingsParsed = DateTime.parse(feelingsDate);
      if (feelingsParsed.isBefore(DateTime.now())) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Feelings()));
      }
      else{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home()));
      }
    }
    else
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Feelings()));
  }
}
