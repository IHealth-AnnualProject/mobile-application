import 'package:betsbi/model/AppSearchBar.dart';
import 'package:betsbi/model/BrickContainer.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../error.dart';

class HomeView extends State<HomePage> {
  int _selectedBottomIndex = 0;

  void _onBottomTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;

    });
  }

  List<User> users = [
    User(0, 'Antoine Daniel', 'Psychologue'),
    User(1, 'Theodore Bulfonorio', 'User'),
    User(2, 'Estebaille', 'Psychologue'),
  ];

  void instanciateLanguage() async {
    await SettingsManager.languageStarted();
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
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  SettingsManager.mapLanguage["MyAccountContainer"] != null
                      ? SettingsManager.mapLanguage["MyAccountContainer"]
                      : "",
                  Icons.home, null, "user.png"),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  SettingsManager.mapLanguage["MyTrainingContainer"] != null
                      ? SettingsManager.mapLanguage["MyTrainingContainer"]
                      : "",
                  Icons.play_for_work, null, "exercise.png"),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  SettingsManager.mapLanguage["MyMemosContainer"] != null
                      ? SettingsManager.mapLanguage["MyMemosContainer"]
                      : "",
                  Icons.wrap_text, null, "notes.png"),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  SettingsManager.mapLanguage["MyAmbianceContainer"] != null
                      ? SettingsManager.mapLanguage["MyAmbianceContainer"]
                      : "",
                  Icons.music_note, null, "training.png"),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  SettingsManager.mapLanguage["MyQuestContainer"] != null
                      ? SettingsManager.mapLanguage["MyQuestContainer"]
                      : "",
                  Icons.not_listed_location, null, "quest.png"),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  SettingsManager.mapLanguage["SettingsContainer"] != null
                      ? SettingsManager.mapLanguage["SettingsContainer"]
                      : "",
                  Icons.settings, Settings(), "settings.png"),
              BrickContainer(
                  Color.fromRGBO(249, 89, 51, 1),
                  SettingsManager.mapLanguage["ErrorContainer"] != null
                      ? SettingsManager.mapLanguage["ErrorContainer"]
                      : "",
                  Icons.error, Error(), "error.png"),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar(SettingsManager.mapLanguage["SearchContainer"] != null
          ? SettingsManager.mapLanguage["SearchContainer"]
          : "",users),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Expanded(
              child: gridView,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(SettingsManager.mapLanguage["HomeFooter"] != null
                ? SettingsManager.mapLanguage["HomeFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(SettingsManager.mapLanguage["AccountFooter"] != null
                ? SettingsManager.mapLanguage["AccountFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(SettingsManager.mapLanguage["ChatFooter"] != null
                ? SettingsManager.mapLanguage["ChatFooter"]
                : ""),
          ),
        ],
        currentIndex: _selectedBottomIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onBottomTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}