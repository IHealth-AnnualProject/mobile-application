import 'package:betsbi/model/AppSearchBar.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class SettingsView extends State<SettingsPage> {
  int _selectedBottomIndex = 0;
  bool currentNotification;
  List<bool> isSelected = [true, false];
  List<User> users = [
    User(0, 'Antoine Daniel', 'Psychologue'),
    User(1, 'Theodore Bulfonorio', 'User'),
    User(2, 'Estebaille', 'Psychologue'),
  ];

  void _onBottomTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
      switch (_selectedBottomIndex) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  void _setLanguage() async {
    await SettingsManager.setLanguage();
    setState(() {});
  }

  void instanciateLanguage() async {
    await SettingsManager.languageStarted();
    setState(() {});
  }

  void setNotification(){

  }

  @override
  Widget build(BuildContext context) {
    instanciateLanguage();
    currentNotification = SettingsManager.cfg.getBool("pushNotification");
    if(currentNotification)
      isSelected = [true, false];
    else
      isSelected = [false, true];
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final statusPushNotification = ToggleButtons(
      color: Colors.white,
      fillColor: Colors.blue,
      borderRadius: BorderRadius.circular(16.0),
      children: <Widget>[
        Text(
          "ON",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "OFF",
          style: TextStyle(color: Colors.white),
        )
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
          if (index == 0)
            SettingsManager.cfg.updateValue("pushNotification", true);
          else
            SettingsManager.cfg.updateValue("pushNotification", false);
        });
      },
      isSelected: isSelected,
    );
    final language = InkWell(
      onTap: () {
        _setLanguage();
      },
      child: new Text(
        SettingsManager.cfg.getString("language") != null
            ? SettingsManager.cfg.getString("language")
            : "",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar(
          SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : "",
          users),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                SettingsManager.mapLanguage["LanguageChanged"] != null
                    ? SettingsManager.mapLanguage["LanguageChanged"]
                    : "",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                width: 20,
              ),
              language,
            ],
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            children: <Widget>[
              Text(
                SettingsManager.mapLanguage["NotificationPushActivated"] != null
                    ? SettingsManager.mapLanguage["NotificationPushActivated"]
                    : "",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              statusPushNotification
            ],
          )
        ],
      ),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      // This trailing comma makes auto-formatting nicer for build methods.
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
      ),
    );
  }
}