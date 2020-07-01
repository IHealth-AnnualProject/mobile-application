import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/legal/controller/DataUsePolicyController.dart';
import 'package:betsbi/services/legal/controller/LegalMentionController.dart';
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
  List<Widget> elementsFromMapContent;
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
    elementsFromMapContent =
        LegalMentionController.generateContentOfLegalPageAccordingToGivenMap(
            this.widget.content);
  }

  getAllUserInformation() async {
    currentUserInformation = new Map<String, dynamic>();
    currentUserInformation =
        await DataUsePolicyController.getCurrentUserProfileInformation(
            userID: SettingsManager.applicationProperties.getCurrentId(),
            context: context,
            isPsy: SettingsManager.applicationProperties.isPsy());
    return DataUsePolicyController.getDataInformationOfUser(
        currentUserInformation: currentUserInformation);
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
            Align(
              alignment: Alignment.center,
              child: DefaultTextTitle(
                title: SettingsManager.mapLanguage["DataUsePolicy"],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: elementsFromMapContent,
            ),
            SizedBox(
              height: 45,
            ),
            FutureBuilder(
              future: getAllUserInformation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Tooltip(
                    message:
                        SettingsManager.mapLanguage["DataUsePolicyToolTipInfo"],
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: isVisible,
                            child: snapshot.data,
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
                      ),
                    ),
                  );
                } else
                  return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
