import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/presentation/FeelingsFontIcons.dart';
import 'package:betsbi/services/feeling/view/FeelingsView.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/FeelingButton.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingsState extends State<FeelingsPage> with WidgetsBindingObserver {
  //todo clean custom scroll view
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
  Widget build(BuildContext context) {
    final gridView = CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: <Widget>[
              FeelingButton(
                idButton: 0,
                text: SettingsManager.mapLanguage["FeelingGood"] != null
                    ? SettingsManager.mapLanguage["FeelingGood"]
                    : "",
                iconData: MyFlutterApp.emo_happy,
                errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                    ? SettingsManager.mapLanguage["WentWrong"]
                    : "",
                colorButton: Colors.lime,
              ),
              FeelingButton(
                idButton: 1,
                text: SettingsManager.mapLanguage["FeelingVeryGood"] != null
                    ? SettingsManager.mapLanguage["FeelingVeryGood"]
                    : "",
                iconData: MyFlutterApp.emo_laugh,
                errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                    ? SettingsManager.mapLanguage["WentWrong"]
                    : "",
                colorButton: Colors.lime[600],
              ),
              FeelingButton(
                idButton: 2,
                text: SettingsManager.mapLanguage["FeelingSad"] != null
                    ? SettingsManager.mapLanguage["FeelingSad"]
                    : "",
                iconData: MyFlutterApp.emo_unhappy,
                errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                    ? SettingsManager.mapLanguage["WentWrong"]
                    : "",
                colorButton: Colors.lime[700],
              ),
              FeelingButton(
                idButton: 3,
                text: SettingsManager.mapLanguage["FeelingVerySad"] != null
                    ? SettingsManager.mapLanguage["FeelingVerySad"]
                    : "",
                iconData: MyFlutterApp.emo_angry,
                errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                    ? SettingsManager.mapLanguage["WentWrong"]
                    : "",
                colorButton: Colors.lime[800],
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DefaultTextTitle(
                  title: SettingsManager.mapLanguage["FeelingQuestion"]),
              SizedBox(
                height: 50,
              ),
              gridView,
              FeelingButton(
                idButton: 4,
                text: SettingsManager.mapLanguage["FeelingStress"] != null
                    ? SettingsManager.mapLanguage["FeelingStress"]
                    : "",
                iconData: MyFlutterApp.emo_cry,
                errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                    ? SettingsManager.mapLanguage["WentWrong"]
                    : "",
                colorButton: Colors.lime[900],
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
