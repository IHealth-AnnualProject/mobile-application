
import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
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
        map: {'name': title, 'description': description, 'reportedUser': toUserId});
    await httpManager.post();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswerThenPopTheContext(successMessage: SettingsManager.mapLanguage["ReportSent"]);
  }
}
