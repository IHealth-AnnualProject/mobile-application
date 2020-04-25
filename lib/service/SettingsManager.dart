import 'dart:collection';
import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';

class SettingsManager {
  static LinkedHashMap<String, dynamic> mapLanguage =
      new LinkedHashMap<String, dynamic>();
  static GlobalConfiguration cfg;
  static bool status = false;
  static FlutterSecureStorage storage;
  static String currentLanguage, language, feelingsDate;

  static Future<Map<String, dynamic>> parseJsonFromAssets(
      String assetsPath) async {
    return await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static void deviceLanguage()
  async {
    String localLanguage = await Devicelocale.currentLocale;
    switch(localLanguage){
      case "fr":
        cfg.updateValue("currentLanguage", "FR");
        cfg.updateValue("language", "EN");
        break;
      default:
        cfg.updateValue("currentLanguage", "EN");
        cfg.updateValue("language", "FR");
        break;
    }
  }

  static void languageStarted() async {
    if (!status) {
      cfg = new GlobalConfiguration();
      await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");

      storage = new FlutterSecureStorage();
      instanciateProperties();
      currentLanguage = await storage.read(key: "currentLanguage");
      language = await storage.read(key: "language");
      loadLanguage(
          'locale/' + await currentLanguage.toLowerCase() + '.json');
      status = true;
    }
  }

  static void instanciateProperties() async {
    currentLanguage = await storage.read(key: "currentLanguage");
    language = await storage.read(key: "language");
    feelingsDate = await storage.read(key: "feelingsDate");
    if(currentLanguage == null) {
      await storage.write(key: "currentLanguage", value: "FR");
    }
    if(language == null) {
      await storage.write(key: "language", value: "EN");
    }
    if(feelingsDate == null) {
      await storage.write(key: "feelingsDate", value: "");
    }

  }

  static Future loadLanguage(String path) async {
    await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");
    mapLanguage = await parseJsonFromAssets(path);
  }

  static void setLanguage() async {
    String temp = currentLanguage;
    mapLanguage =
    await parseJsonFromAssets('locale/' + language.toLowerCase() + '.json');
    await storage.write(key: "currentLanguage", value: language);
    await storage.write(key: "language", value: currentLanguage);
    currentLanguage = language;
    language = temp;

  }
}
