import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  static DataTable getDataInformationOfUser({Map<String, dynamic> currentUserInformation})
  {
    List<DataColumn> headersList = new List<DataColumn>();
    List<DataCell> rowList = new List<DataCell>();
    currentUserInformation.forEach((header, row) {
      if (header != "id" && header != "user") {
        headersList.add(
          DataColumn(
            label: Expanded(
              child :
              Text(
              header,
              style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        );
        rowList.add(DataCell(Text(row.toString())));
      }
    });
    currentUserInformation["user"].forEach((header, row) {
      if (header != "id") {
        headersList.add(
          DataColumn(
            label: Text(
              header,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        );
        rowList.add(DataCell(Text(row.toString())));
      }
    });
    return DataTable(
      columns: headersList,
      rows: <DataRow>[DataRow(cells: rowList)],
    );
  }
}