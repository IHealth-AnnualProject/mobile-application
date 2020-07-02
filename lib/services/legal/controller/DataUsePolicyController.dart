import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataUsePolicyController {

  static Future<Map<String, dynamic>> getCurrentUserProfileInformation({
      @required String userID, @required BuildContext context, @required String isPsy}) async {
    String userPath = isPsy.toLowerCase() == 'true' ? 'psychologist' : 'userProfile';
    HttpManager httpManager =
        new HttpManager(path:  '$userPath/$userID/user', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
    return responseManager.checkResponseRetrieveInformationWithAFunction(
        toReturn: () => JsonParserManager.parseJsonFromResponseToMap(
            httpManager.response.body),elementToReturnIfFalse: new Map<String, dynamic>());
  }

  static DataTable getDataInformationOfUser(
      {Map<String, dynamic> currentUserInformation}) {
    List<DataColumn> headersList = new List<DataColumn>();
    List<DataCell> rowList = new List<DataCell>();
    currentUserInformation.forEach((header, row) {
      if (header != "id" && header != "user") {
        headersList.add(
          DataColumn(
            label: Expanded(
              child: Text(
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
