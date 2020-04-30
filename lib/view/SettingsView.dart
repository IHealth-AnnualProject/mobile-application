import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  SettingsView createState() => SettingsView();
}

class SettingsView extends State<SettingsPage> {
  bool currentNotification;
  List<bool> isSelected = [true, false];

  void _setLanguage() {
    SettingsManager.setLanguage().then((r) => setState(() {}));
  }

  void instanciateLanguage() {
    SettingsManager.languageStarted().then((r) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    instanciateLanguage();
    currentNotification = SettingsManager.cfg.getBool("pushNotification");
    if (currentNotification)
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
    RaisedButton disconnectButton() {
      return RaisedButton(
        elevation: 8,
        shape: StadiumBorder(),
        color: Color.fromRGBO(104, 79, 37, 0.8),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          SettingsController.disconnect(context);
        },
        child: Text(
          SettingsManager.mapLanguage["Logout"] != null
              ? SettingsManager.mapLanguage["Logout"]
              : "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
      );
    }
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
        SettingsManager.language != null ? SettingsManager.language : "",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.AppSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
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
          ),
          disconnectButton(),
        ],
      ),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
