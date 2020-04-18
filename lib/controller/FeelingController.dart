import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class FeelingController{

  static void redirection(BuildContext context){
    SettingsManager.cfg.updateValue("feelingsDate", DateTime.now().toString());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
}