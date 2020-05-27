import 'dart:collection';
import 'package:betsbi/service/JsonParserManager.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';

class SettingsManager {
  static LinkedHashMap<String, dynamic> mapLanguage =
      new LinkedHashMap<String, dynamic>();
  static GlobalConfiguration cfg;
  static FlutterSecureStorage storage;
  static String firstEntry;
  static int newMessage = 0;
  static String currentLanguage,
      language,
      feelingsDate,
      currentToken,
      currentId,
      isPsy;

  static void deviceLanguage() async {
    String localLanguage = await Devicelocale.currentLocale;
    switch (localLanguage) {
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

  static Future<void> instanciateConfigurationAndLoadLanguage() async {
    cfg = new GlobalConfiguration();
    storage = new FlutterSecureStorage();
    await GlobalConfiguration().loadFromPath("assets/cfg/settings.json").then(
        (r) => instanciateConfiguration().then((r) =>
            loadLanguage('locale/' + currentLanguage.toLowerCase() + '.json')));
  }

  static Future<void> instanciateConfiguration() async {
    currentLanguage = await storage.read(key: "currentLanguage");
    if (currentLanguage == null) {
      await storage.write(key: "currentLanguage", value: "FR");
      currentLanguage = await storage.read(key: "currentLanguage");
    }
    language = await storage.read(key: "language");
    if (language == null) {
      await storage.write(key: "language", value: "EN");
      language = await storage.read(key: "language");
    }
    feelingsDate = await storage.read(key: "feelingsDate");
    if (feelingsDate == null) {
      await storage.write(key: "feelingsDate", value: "");
      feelingsDate = await storage.read(key: "feelingsDate");
    }
    isPsy = await storage.read(key: "isPsy");
    if (isPsy == null) {
      await storage.write(key: "isPsy", value: "false");
      isPsy = await storage.read(key: "isPsy");
    }
    firstEntry = await storage.read(key: "firstEntry");
    if (firstEntry == null) {
      await storage.write(key: "firstEntry", value: "true");
      firstEntry = await storage.read(key: "firstEntry");
    }
  }

  static Future<void> updateValueOfConfigurationSecureStorage(
          String key, String value) async =>
      await storage.write(key: key, value: value);

  static Future<void> loadLanguage(String path) async =>
      mapLanguage = await JsonParserManager.parseJsonFromAssetsToMap(path);

  static Future<void> setLanguage() async {
    String temp = currentLanguage;
    mapLanguage = await JsonParserManager.parseJsonFromAssetsToMap(
        'locale/' + language.toLowerCase() + '.json');
    await storage.write(key: "currentLanguage", value: language);
    await storage.write(key: "language", value: currentLanguage);
    currentLanguage = language;
    language = temp;
  }
}
