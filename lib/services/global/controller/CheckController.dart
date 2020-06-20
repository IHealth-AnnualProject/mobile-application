import 'package:betsbi/manager/SettingsManager.dart';

class CheckController{

  static String _checkEmail(String email){
     if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return SettingsManager.mapLanguage["EmailErrorText"] != null
          ? SettingsManager.mapLanguage["EmailErrorText"]
          : "";
    }
     return null;
  }

  static String checkField(String content, {String passwordToCheck, String emailToCheck})
  {
    if (content.isEmpty) {
      return SettingsManager.mapLanguage["EnterText"] != null
          ? SettingsManager.mapLanguage["EnterText"]
          : "";
    }
    if(passwordToCheck != null){
      return _checkConfirmPassword(content, passwordToCheck);
    }
    if(emailToCheck != null){
      return _checkEmail(emailToCheck);
    }
    return null;
  }

  static String _checkConfirmPassword(String content, String passwordToCheck)
  {
    if (content != passwordToCheck) {
      return SettingsManager.mapLanguage["NotSamePassword"] != null
          ? SettingsManager.mapLanguage["NotSamePassword"]
          : "";
    }
    return null;
  }

}