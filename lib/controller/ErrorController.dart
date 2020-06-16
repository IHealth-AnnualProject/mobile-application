import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';

class ErrorController {
  static Future<void> sendError(
      {@required context, @required String name, @required String description}) async {
    HttpManager httpManager = new HttpManager(
      path: "error",
      context: context,
      map: {'name': name, 'description': description},
    );
    await httpManager.post();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      successMessage: SettingsManager.mapLanguage["ErrorSent"],
      context: context
    );
    responseManager.checkResponseAndPrintIt();
  }
}
