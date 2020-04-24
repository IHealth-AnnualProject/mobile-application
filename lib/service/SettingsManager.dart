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
    cfg = new GlobalConfiguration();
    await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");
    if (!cfg.getBool("statusSettings")) {
      loadLanguage(
          'locale/' + cfg.getString('currentLanguage').toLowerCase() + '.json');
      storage = new FlutterSecureStorage();
      cfg.updateValue("statusSettings", true);
    }
  }

  static Future loadLanguage(String path) async {
    await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");
    mapLanguage = await parseJsonFromAssets(path);
  }

  static void setLanguage() async {
    mapLanguage =
    await parseJsonFromAssets('locale/' + cfg.getString("language").toLowerCase() + '.json');
    String oldLanguage = cfg.getString("currentLanguage");
    cfg.updateValue("currentLanguage", cfg.getString("language"));
    cfg.updateValue("language", oldLanguage);
  }
}
