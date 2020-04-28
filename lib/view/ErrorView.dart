import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/FinalButton.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key key}) : super(key: key);

  @override
  ErrorView createState() => ErrorView();
}

class ErrorView extends State<ErrorPage> {
  final _formKey = GlobalKey<FormState>();
  List<User> users = [
    User(0, 'Antoine Daniel', 'Psychologue', 1),
    User(1, 'Theodore Bulfonorio', 'User', 1),
    User(2, 'Estebaille', 'Psychologue', 1),
  ];

  void instanciateLanguage() {
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

    final titleFeelings = Text(
      SettingsManager.mapLanguage["ErrorTitle"] != null
          ? SettingsManager.mapLanguage["ErrorTitle"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 100),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
    final titleError = TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["Title"] != null
              ? SettingsManager.mapLanguage["Title"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["Title"] != null
              ? SettingsManager.mapLanguage["Title"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final descriptionError = TextFormField(
      obscureText: false,
      textAlign: TextAlign.start,
      maxLines: 15,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Description",
          filled: true,
          fillColor: Colors.white,
          hintText: "Description",
          alignLabelWithHint: true,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.AppSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : "",
          users: users),
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
              SizedBox(
                height: 30,
              ),
              titleFeelings,
              SizedBox(
                height: 45,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 350.0,
                      child: titleError,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: descriptionError,
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: 350.0,
                      child: FinalButton(
                          content: SettingsManager.mapLanguage["Submit"] != null
                              ? SettingsManager.mapLanguage["Submit"]
                              : "",
                          destination: HomePage(),
                          formKey: _formKey,
                          barContent:
                              SettingsManager.mapLanguage["ErrorSent"] != null
                                  ? SettingsManager.mapLanguage["ErrorSent"]
                                  : ""),
                    ),
                  ],
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ))),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
