import 'package:betsbi/customwidgets/BrickContainer.dart';
import 'package:betsbi/customwidgets/SearchApp.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/Language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

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
                  Language.mapLanguage["MyAccountContainer"] != null
                      ? Language.mapLanguage["MyAccountContainer"]
                      : "",
                  Icons.home),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  Language.mapLanguage["MyTrainingContainer"] != null
                      ? Language.mapLanguage["MyTrainingContainer"]
                      : "",
                  Icons.play_for_work),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  Language.mapLanguage["MyMemosContainer"] != null
                      ? Language.mapLanguage["MyMemosContainer"]
                      : "",
                  Icons.wrap_text),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  Language.mapLanguage["MyAmbianceContainer"] != null
                      ? Language.mapLanguage["MyAmbianceContainer"]
                      : "",
                  Icons.music_note),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  Language.mapLanguage["MyQuestContainer"] != null
                      ? Language.mapLanguage["MyQuestContainer"]
                      : "",
                  Icons.not_listed_location),
              BrickContainer(
                  Color.fromRGBO(51, 171, 249, 1),
                  Language.mapLanguage["SettingsContainer"] != null
                      ? Language.mapLanguage["SettingsContainer"]
                      : "",
                  Icons.settings),
              BrickContainer(
                  Color.fromRGBO(249, 89, 51, 1),
                  Language.mapLanguage["ErrorContainer"] != null
                      ? Language.mapLanguage["ErrorContainer"]
                      : "",
                  Icons.error),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(users));
              })
        ],
      ),
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
            title: Text(Language.mapLanguage["HomeFooter"] != null
                ? Language.mapLanguage["HomeFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(Language.mapLanguage["AccountFooter"] != null
                ? Language.mapLanguage["AccountFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(Language.mapLanguage["ChatFooter"] != null
                ? Language.mapLanguage["ChatFooter"]
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