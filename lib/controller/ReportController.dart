import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';

class ReportController {
  static Future<void> sendReport(
      {@required BuildContext context,
      @required String toUserId,
      @required String title,
      @required String description}) async {
    HttpManager httpManager = new HttpManager(
        path: "report",
        context: context,
        map: {'name': title, 'description': description, 'to': toUserId});
    await httpManager.post();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      successMessage: SettingsManager.mapLanguage["ReportSent"],
      context: context,
    );
    responseManager.checkResponseAndPrintItThenPopBack();
  }
}
