import 'package:betsbi/service/SettingsManager.dart';

class CheckController{

  static String checkEmail(String email){
    if (email.isEmpty) {
      return SettingsManager.mapLanguage["EnterText"] != null
          ? SettingsManager.mapLanguage["EnterText"]
          : "";
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return SettingsManager.mapLanguage["EmailErrorText"] != null
          ? SettingsManager.mapLanguage["EmailErrorText"]
          : "";
    }
    else return null;
  }

}