import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataUsePolicyController {
  static Future<Map<String, dynamic>> getCurrentUserProfileInformation(
      {@required String userID,
      @required BuildContext context,
      @required String isPsy}) async {
    String userPath =
        isPsy.toLowerCase() == 'true' ? 'psychologist' : 'userProfile';
    HttpManager httpManager =
        new HttpManager(path: '$userPath/$userID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager.checkResponseRetrieveInformationWithAFunction(
        toReturn: () => JsonParserManager.parseJsonFromResponseToMap(
            httpManager.response.body),
        elementToReturnIfFalse: new Map<String, dynamic>());
  }

  static Future<void> deleteCurrentAccount(
      {@required BuildContext context}) async {
    HttpManager httpManager = new HttpManager(path: 'auth', context: context);
    await httpManager.delete();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,
        onSuccess: () => SettingsController.disconnect(context));
    print(httpManager.response.body + httpManager.response.statusCode.toString());
    responseManager.checkResponseAndShowWithFlushBarMessageTheAnswer(
        successMessage: SettingsManager.mapLanguage["DeleteAccountResult"]);
  }

  static DataTable getDataInformationOfUserAsDataTable(
      {@required Map<String, dynamic> currentUserInformation}) {
    List<DataColumn> headersList = new List<DataColumn>();
    List<DataRow> rowsList = new List<DataRow>();
    headersList.add(DataColumn(
      label: Expanded(
        child: Text(
          'Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));
    headersList.add(DataColumn(
      label: Expanded(
        child: Text(
          SettingsManager.mapLanguage["Content"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));

    currentUserInformation.forEach((header, row) {
      if (header != "id" && header != "user") {
        rowsList.add(DataRow(cells: [
          DataCell(Text(header.toString())),
          DataCell(Text(row.toString()))
        ]));
      }
    });
    currentUserInformation["user"].forEach((header, row) {
      if (header != "id") {
        rowsList.add(DataRow(cells: [
          DataCell(Text(header.toString())),
          DataCell(Text(row.toString()))
        ]));
      }
    });
    return DataTable(
      dividerThickness: 5,
      columns: headersList,
      rows: rowsList,
    );
  }
}
