import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';

class SettingsManager {
  static LinkedHashMap<String, dynamic> mapLanguage =
      new LinkedHashMap<String, dynamic>();
  static GlobalConfiguration cfg;
  static bool status = false;

  static Future<Map<String, dynamic>> parseJsonFromAssets(
      String assetsPath) async {
    return await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static void languageStarted() async {
    if (!status) {
      cfg = new GlobalConfiguration();
      await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");
      loadLanguage(
          'locale/' + cfg.getString('currentLanguage').toLowerCase() + '.json');
      status = true;
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
