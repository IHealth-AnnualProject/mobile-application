import 'package:betsbi/account.dart';
import 'package:betsbi/controller/ContainerController.dart';
import 'package:betsbi/model/AppSearchBar.dart';
import 'package:betsbi/model/BottomNavigationBarFooter.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountView extends State<AccountPage> {
  int _selectedBottomIndex = 1;
  User user = new User(0, 'Antoine Daniel', 'Psychologue');

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
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar(
          SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : "",
          ContainerController.users),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black87,
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }
}
