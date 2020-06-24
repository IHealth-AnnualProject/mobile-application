import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/legal/controller/LegalMentionController.dart';
import 'package:betsbi/services/legal/view/CompatibilityView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompatibilityState extends State<CompatibilityPage>
    with WidgetsBindingObserver {
  List<Widget> elementsFromMapContent;

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
                title: SettingsManager.mapLanguage["Compatibility"],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: elementsFromMapContent,
            ),
          ],
        ),
      ),
    );
  }
}
