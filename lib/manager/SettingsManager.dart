import 'dart:collection';
import 'package:betsbi/manager/GeolocationManager.dart';
import 'package:betsbi/services/account/controller/SkinController.dart';
import 'package:betsbi/services/settings/model/applicationProperties.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';

import 'JsonParserManager.dart';
import 'NotificationManager.dart';

class SettingsManager {
  static LinkedHashMap<String, dynamic> mapLanguage =
      new LinkedHashMap<String, dynamic>();
  static GlobalConfiguration cfg;
  static FlutterSecureStorage storage;
  static ApplicationProperties applicationProperties =
      new ApplicationProperties.defaultConstructor();


  static Future<void> instantiateConfigurationAndLoadLanguage() async {
    cfg = new GlobalConfiguration();
    storage = new FlutterSecureStorage();
    await GeolocationManager.askForPermission();
    await GlobalConfiguration().loadFromPath("assets/cfg/settings.json").then(
          (r) => instantiateConfiguration().then(
            (r) => loadLanguage('locale/' +
                applicationProperties.getCurrentLanguage().toLowerCase() +
                '.json'),
          ),
        );
  }

  static Future<void> instantiateConfiguration() async {
    await applicationProperties.getCurrentLanguageOfApplication(storage);
    await applicationProperties.getLanguageOfApplication(storage);
    await applicationProperties.getFeelingsDateOfApplication(storage);
    await applicationProperties.getPsyOfApplication(storage);
    await applicationProperties.getFirstEntryOfApplication(storage);
    await applicationProperties
        .getNotificationPushedActivatedOfApplication(storage);
    await NotificationManager.initializeNotification();
    await SkinController.getSkinParametersFromJsonInList();
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

  static Future<void> setNotificationPush(String status) async {
    await storage.write(key: "notificationPush", value: status);
    applicationProperties.setNotificationPushActivated(status);
  }
}
