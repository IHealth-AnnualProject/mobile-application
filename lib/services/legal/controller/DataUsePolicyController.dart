import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:flutter/cupertino.dart';

class DataUsePolicyController {

  static Future<Map<String, dynamic>> getCurrentUserProfileInformation(
      String userID, BuildContext context) async {
    HttpManager httpManager =
    new HttpManager(path: 'userProfile/$userID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,
        elementToReturn: new Map<String, dynamic>(),
        functionFromJsonToReturn: () => JsonParserManager.parseJsonFromResponseToMap(httpManager.response.body));
    return responseManager.checkResponseAndRetrieveInformationFromJson();
  }

  static Future<Map<String, dynamic>> getCurrentPsyProfileInformation(
      String userID, BuildContext context) async {
    HttpManager httpManager =
    new HttpManager(path: 'psychologist/$userID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,
        elementToReturn: new Map<String, dynamic>(),
        functionFromJsonToReturn: () => JsonParserManager.parseJsonFromResponseToMap(httpManager.response.body));
    return responseManager.checkResponseAndRetrieveInformationFromJson();
  }

}