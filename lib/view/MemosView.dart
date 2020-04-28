import 'package:betsbi/controller/ContainerController.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemosPage extends StatefulWidget {
  MemosPage({Key key}) : super(key: key);

  @override
  MemosView createState() => MemosView();
}

class MemosView extends State<MemosPage> {
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

    final titleMemos = Text(
      SettingsManager.mapLanguage["MemosTitle"] != null
          ? SettingsManager.mapLanguage["MemosTitle"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(104, 79, 37, 0.8),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.AppSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : "",
          users: ContainerController.users),
      body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              width: 200,
              child: Image(
                image: AssetImage("assets/notes.png"),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleMemos,
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
