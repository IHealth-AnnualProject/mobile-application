import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/JsonParserManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/legal/view/CompatibilityView.dart';
import 'package:betsbi/services/legal/view/ContributorsView.dart';
import 'package:betsbi/services/legal/view/LegalMentionView.dart';
import 'package:betsbi/services/legal/view/DataUsePolicyView.dart';
import 'package:betsbi/services/legal/view/ServiceConditionView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultCircleAvatar.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegalMentionState extends State<LegalMentionPage> with WidgetsBindingObserver {
  Map<String, dynamic> contentServiceCondition;
  Map<String, dynamic> contentCompatibility;
  Map<String, dynamic> contentDataUsePolicy;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    prepareInformationToShowInNextLegalPage();
  }

  void prepareInformationToShowInNextLegalPage() async{
    String currentLanguage = SettingsManager.applicationProperties.getCurrentLanguage().toLowerCase();
    contentServiceCondition = await JsonParserManager.parseJsonFromAssetsToMap("assets/legal/$currentLanguage/cgu.json");
    contentCompatibility = await JsonParserManager.parseJsonFromAssetsToMap("assets/legal/$currentLanguage/compatibility.json");
    contentDataUsePolicy = await JsonParserManager.parseJsonFromAssetsToMap("assets/legal/$currentLanguage/dataUsePolicy.json");
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOnline: null,
        isOffLine: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            DefaultCircleAvatar(
              imagePath: "assets/aboutUs.png",
            ),
            SizedBox(
              height: 20,
            ),
            DefaultTextTitle(
              title: SettingsManager.mapLanguage["LegalMentionAndRules"],
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 10,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceConditionPage(content: contentServiceCondition,)),
                ),
                title: Text(SettingsManager.mapLanguage["ServiceCondition"]),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataUsePolicyPage(content: contentDataUsePolicy,)),
                ),
                title: Text(SettingsManager.mapLanguage["DataUsePolicy"]),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompatibilityPage(content: contentCompatibility,)),
                ),
                title: Text(SettingsManager.mapLanguage["Compatibility"]),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContributorsPage(content: null ,)),
                ),
                title: Text(SettingsManager.mapLanguage["Contributors"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
