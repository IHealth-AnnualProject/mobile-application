import 'package:betsbi/presentation/FeelingsFontIcons.dart';
import 'package:betsbi/widget/FeelingButton.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingsPage extends StatefulWidget {
  FeelingsPage({Key key}) : super(key: key);

  @override
  FeelingsView createState() => FeelingsView();
}

class FeelingsView extends State<FeelingsPage> {
  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

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
                      : ""),
              FeelingButton(
                  idButton: 1,
                  text: SettingsManager.mapLanguage["FeelingVeryGood"] != null
                      ? SettingsManager.mapLanguage["FeelingVeryGood"]
                      : "",
                  iconData: MyFlutterApp.emo_laugh,
                  errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                      ? SettingsManager.mapLanguage["WentWrong"]
                      : ""),
              FeelingButton(
                  idButton: 2,
                  text: SettingsManager.mapLanguage["FeelingSad"] != null
                      ? SettingsManager.mapLanguage["FeelingSad"]
                      : "",
                  iconData: MyFlutterApp.emo_unhappy,
                  errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                      ? SettingsManager.mapLanguage["WentWrong"]
                      : ""),
              FeelingButton(
                  idButton: 3,
                  text: SettingsManager.mapLanguage["FeelingVerySad"] != null
                      ? SettingsManager.mapLanguage["FeelingVerySad"]
                      : "",
                  iconData: MyFlutterApp.emo_angry,
                  errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                      ? SettingsManager.mapLanguage["WentWrong"]
                      : ""),
              FeelingButton(
                  idButton: 4,
                  text: SettingsManager.mapLanguage["FeelingStress"] != null
                      ? SettingsManager.mapLanguage["FeelingStress"]
                      : "",
                  iconData: MyFlutterApp.emo_cry,
                  errorMessage: SettingsManager.mapLanguage["WentWrong"] != null
                      ? SettingsManager.mapLanguage["WentWrong"]
                      : ""),
            ],
          ),
        ),
      ],
    );
    final titleFeelings = Text(
      SettingsManager.mapLanguage["FeelingQuestion"] != null
          ? SettingsManager.mapLanguage["FeelingQuestion"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 100),
          fontWeight: FontWeight.bold,
          fontSize: 40),
    );
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 228, 228, 1),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                titleFeelings,
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: gridView,
                )
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
