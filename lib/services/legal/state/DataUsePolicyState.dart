import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/legal/controller/DataUsePolicyController.dart';
import 'package:betsbi/services/legal/view/DataUsePolicyView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataUsePolicyState extends State<DataUsePolicyPage>
    with WidgetsBindingObserver {
  Map<String, dynamic> currentUserInformation;
  Map<String, dynamic> currentUserProfileInformation;
  List<DataColumn> headersList = new List<DataColumn>();
  List<DataCell> rowList = new List<DataCell>();
  bool isVisible = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }

  getAllUserInformation() async {
    currentUserInformation = new Map<String, dynamic>();
    SettingsManager.applicationProperties.isPsy() == 'true'
        ? currentUserInformation =
            await DataUsePolicyController.getCurrentPsyProfileInformation(
                SettingsManager.applicationProperties.getCurrentId(), context)
        : currentUserInformation =
            await DataUsePolicyController.getCurrentUserProfileInformation(
                SettingsManager.applicationProperties.getCurrentId(), context);
    currentUserInformation.forEach((header, row) {
      if (header != "id" && header != "user") {
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
    return currentUserInformation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOnline: null,
        isOffLine: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            DefaultTextTitle(
              title: SettingsManager.mapLanguage["DataUsePolicy"],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "1 : " + SettingsManager.mapLanguage["Collect"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["Collect"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "2 : " + SettingsManager.mapLanguage["DataUse"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["DataUse"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "3 : " + SettingsManager.mapLanguage["PrivacyOnlineShop"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["PrivacyOnlineShop"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "4 : " + SettingsManager.mapLanguage["ThirdParties"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["ThirdParties"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "5 : " + SettingsManager.mapLanguage["ProtectionOfInformation"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["ProtectionOfInformation"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "6 : " + SettingsManager.mapLanguage["Cookies"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["Cookies"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "7 : " + SettingsManager.mapLanguage["Consent"],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              this.widget.content["Consent"],
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
            SizedBox(
              height: 45,
            ),
            FutureBuilder(
              future: getAllUserInformation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: isVisible,
                        child: DataTable(
                          columns: headersList,
                          rows: <DataRow>[DataRow(cells: rowList)],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Visibility(
                        visible: !isVisible,
                        child: SubmitButton(
                          content: SettingsManager
                              .mapLanguage["SeePersonalInformation"],
                          onPressedFunction: () => this.setState(
                            () {
                              isVisible = true;
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else
                  return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
