import 'package:betsbi/presentation/my_flutter_app_icons.dart';
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
  void instanciateLanguage()  {
    SettingsManager.languageStarted().then((r) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    instanciateLanguage();
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
                  SettingsManager.mapLanguage["FeelingGood"] != null
                      ? SettingsManager.mapLanguage["FeelingGood"]
                      : "",
                  MyFlutterApp.emo_happy),
              FeelingButton(
                  SettingsManager.mapLanguage["FeelingVeryGood"] != null
                      ? SettingsManager.mapLanguage["FeelingVeryGood"]
                      : "",
                  MyFlutterApp.emo_laugh),
              FeelingButton(
                  SettingsManager.mapLanguage["FeelingSad"] != null
                      ? SettingsManager.mapLanguage["FeelingSad"]
                      : "",
                  MyFlutterApp.emo_unhappy),
              FeelingButton(
                  SettingsManager.mapLanguage["FeelingVerySad"] != null
                      ? SettingsManager.mapLanguage["FeelingVerySad"]
                      : "",
                  MyFlutterApp.emo_angry),
              FeelingButton(
                  SettingsManager.mapLanguage["FeelingStress"] != null
                      ? SettingsManager.mapLanguage["FeelingStress"]
                      : "",
                  MyFlutterApp.emo_cry),
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
