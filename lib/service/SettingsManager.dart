import 'dart:collection';
import 'package:betsbi/model/applicationProperties.dart';
import 'package:betsbi/service/JsonParserManager.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';

class SettingsManager {
  static LinkedHashMap<String, dynamic> mapLanguage =
      new LinkedHashMap<String, dynamic>();
  static GlobalConfiguration cfg;
  static FlutterSecureStorage storage;
  static ApplicationProperties applicationProperties =
      new ApplicationProperties.defaultConstructor();

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
          (r) => instanciateConfiguration().then(
            (r) => loadLanguage('locale/' +
                applicationProperties.getCurrentLanguage().toLowerCase() +
                '.json'),
          ),
        );
  }

  static Future<void> instanciateConfiguration() async {
    await applicationProperties.getCurrentLanguageOfApplication(storage);
    await applicationProperties.getLanguageOfApplication(storage);
    await applicationProperties.getFeelingsDateOfApplication(storage);
    await applicationProperties.getPsyOfApplication(storage);
    await applicationProperties.getFirstEntryOfApplication(storage);
  }

  static Future<void> updateValueOfConfigurationSecureStorage(
          String key, String value) async =>
      await storage.write(key: key, value: value);

  static Future<void> loadLanguage(String path) async =>
      mapLanguage = await JsonParserManager.parseJsonFromAssetsToMap(path);

  static Future<void> setLanguage() async {
    String temp = applicationProperties.getCurrentLanguage();
    mapLanguage = await JsonParserManager.parseJsonFromAssetsToMap('locale/' +
        applicationProperties.getLanguage().toLowerCase() +
        '.json');
    await storage.write(
        key: "currentLanguage", value: applicationProperties.getLanguage());
    await storage.write(
        key: "language", value: applicationProperties.getCurrentLanguage());
    applicationProperties
        .setCurrentLanguage(applicationProperties.getLanguage());
    applicationProperties.setLanguage(temp);
  }
}
