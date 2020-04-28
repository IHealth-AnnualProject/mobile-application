import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/BrickContainer.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/MemosView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AccountView.dart';
import 'ErrorView.dart';
import 'SettingsView.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomeView createState() => HomeView();
}

class HomeView extends State<HomePage> {
  int _selectedBottomIndex = 0;

  List<User> users = [
    User(0, 'Antoine Daniel', 'Psychologue', 1),
    User(1, 'Theodore Bulfonorio', 'User', 1),
    User(2, 'Estebaille', 'Psychologue', 1),
  ];

  void instanciateLanguage() {
    SettingsManager.languageStarted().then((r) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
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
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyAccountContainer"] != null
                          ? SettingsManager.mapLanguage["MyAccountContainer"]
                          : "",
                  iconBrick: Icons.home,
                  destination: AccountPage(),
                  image: "user.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyTrainingContainer"] != null
                          ? SettingsManager.mapLanguage["MyTrainingContainer"]
                          : "",
                  iconBrick: Icons.play_for_work,
                  destination: null,
                  image: "exercise.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyMemosContainer"] != null
                          ? SettingsManager.mapLanguage["MyMemosContainer"]
                          : "",
                  iconBrick: Icons.wrap_text,
                  destination: MemosPage(),
                  image: "notes.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyAmbianceContainer"] != null
                          ? SettingsManager.mapLanguage["MyAmbianceContainer"]
                          : "",
                  iconBrick: Icons.music_note,
                  destination: AmbiancePage(),
                  image: "training.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyQuestContainer"] != null
                          ? SettingsManager.mapLanguage["MyQuestContainer"]
                          : "",
                  iconBrick: Icons.not_listed_location,
                  destination: null,
                  image: "quest.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["SettingsContainer"] != null
                          ? SettingsManager.mapLanguage["SettingsContainer"]
                          : "",
                  iconBrick: Icons.settings,
                  destination: SettingsPage(),
                  image: "settings.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(249, 89, 51, 1),
                  textBrick:
                      SettingsManager.mapLanguage["ErrorContainer"] != null
                          ? SettingsManager.mapLanguage["ErrorContainer"]
                          : "",
                  iconBrick: Icons.error,
                  destination: ErrorPage(),
                  image: "error.png"),
            ],
          ),
        ),
      ],
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: gridView,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
          _selectedBottomIndex), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
