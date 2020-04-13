import 'package:betsbi/customwidgets/FeelingButton.dart';
import 'package:betsbi/feelings.dart';
import 'package:betsbi/service/Language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingsView extends State<FeelingsPage> {
  void instanciateLanguage() async {
    await Language.languageStarted();
    setState(() {});
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

    final titleFeelings = Text(
      Language.mapLanguage["FeelingQuestion"] != null
          ? Language.mapLanguage["FeelingQuestion"]
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titleFeelings,
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 350.0,
                      child: FeelingButton(
                          Language.mapLanguage["FeelingGood"] != null
                              ? Language.mapLanguage["FeelingGood"]
                              : ""),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: FeelingButton(
                          Language.mapLanguage["FeelingVeryGood"] != null
                              ? Language.mapLanguage["FeelingVeryGood"]
                              : ""),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: FeelingButton(
                          Language.mapLanguage["FeelingSad"] != null
                              ? Language.mapLanguage["FeelingSad"]
                              : ""),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: FeelingButton(
                          Language.mapLanguage["FeelingVerySad"] != null
                              ? Language.mapLanguage["FeelingVerySad"]
                              : ""),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: FeelingButton(
                          Language.mapLanguage["FeelingStress"] != null
                              ? Language.mapLanguage["FeelingStress"]
                              : ""),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: FeelingButton(
                          Language.mapLanguage["FeelingDepressive"] != null
                              ? Language.mapLanguage["FeelingDepressive"]
                              : ""),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
