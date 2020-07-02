import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationProperties {
  String _firstEntry;
  int _newMessage = 0;
  String _notificationPushedActivated;

  String _currentLanguage,
      _language,
      _feelingsDate,
      _currentToken,
      _currentId,
      _isPsy;

  ApplicationProperties.defaultConstructor();

  String getCurrentLanguage() => this._currentLanguage;
  String getLanguage() => this._language;
  String getFirstEntry() => this._firstEntry;
  int getNewMessage() => this._newMessage;
  String getFeelingsDate() => this._feelingsDate;
  String getCurrentToken() => this._currentToken;
  String getCurrentId() => this._currentId;
  String isPsy() => this._isPsy;
  String areNotificationPushActivated() => this._notificationPushedActivated;

  void setCurrentLanguage(String newLanguage) =>
      this._currentLanguage = newLanguage;
  void setLanguage(String newLanguage) => this._language = newLanguage;
  void setFirstEntry(String firstEntry) => this._firstEntry = firstEntry;
  void setNewMessage(int newMessage) => this._newMessage = newMessage;
  void setFeelingsDate(String feelingsDate) =>
      this._feelingsDate = feelingsDate;
  void setCurrentToken(String token) => this._currentToken = token;
  void setCurrentId(String id) => this._currentId = id;
  void setIsPsy(String isPsy) => this._isPsy = isPsy;
  void setNotificationPushActivated(String notificationPushActivated) => this._notificationPushedActivated = notificationPushActivated;

  Future<void> getCurrentLanguageOfApplication(FlutterSecureStorage storage) async {
    setCurrentLanguage(await storage.read(key: "currentLanguage"));
    if (getCurrentLanguage() == null) {
      await storage.write(key: "currentLanguage", value: "FR");
      setCurrentLanguage(await storage.read(key: "currentLanguage"));
    }
  }

  Future<void> getLanguageOfApplication(FlutterSecureStorage storage) async {
    setLanguage(await storage.read(key: "language"));
    if (getLanguage() == null) {
      await storage.write(key: "language", value: "EN");
      setLanguage(await storage.read(key: "language"));
    }
  }

  Future<void> getFeelingsDateOfApplication(FlutterSecureStorage storage) async {
    setFeelingsDate(await storage.read(key: "feelingsDate"));
    if (getFeelingsDate() == null) {
      await storage.write(key: "feelingsDate", value: "");
      setFeelingsDate(await storage.read(key: "feelingsDate"));
    }
  }

  Future<void> getPsyOfApplication(FlutterSecureStorage storage) async {
    setIsPsy(await storage.read(key: "isPsy"));
    if (isPsy() == null) {
      await storage.write(key: "isPsy", value: "false");
      setIsPsy(await storage.read(key: "isPsy"));
    }
  }

  Future<void> getFirstEntryOfApplication(FlutterSecureStorage storage) async {
    setFirstEntry(await storage.read(key: "firstEntry"));
    if (getFirstEntry() == null) {
      await storage.write(key: "firstEntry", value: "true");
      setFirstEntry(await storage.read(key: "firstEntry"));
    }
  }
  Future<void> getNotificationPushedActivatedOfApplication(FlutterSecureStorage storage) async {
    setNotificationPushActivated(await storage.read(key: "notificationPush"));
    if (areNotificationPushActivated() == null) {
      await storage.write(key: "notificationPush", value: "false");
      setNotificationPushActivated(await storage.read(key: "notificationPush"));
    }
  }
}
