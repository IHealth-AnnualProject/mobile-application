import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsView createState() => _SettingsView();
}

class _SettingsView extends State<SettingsPage> with WidgetsBindingObserver {
  bool currentNotification;
  List<bool> isSelected = [true, false];

  void _setLanguage() {
    SettingsManager.setLanguage().then((r) => setState(() {}));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentNotification = SettingsManager.cfg.getBool("pushNotification");
    if (currentNotification)
      isSelected = [true, false];
    else
      isSelected = [false, true];
    RaisedButton disconnectButton() {
      return RaisedButton(
        elevation: 8,
        shape: StadiumBorder(),
        color: Color.fromRGBO(255, 195, 0, 1),
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

    RaisedButton reloadIntroductionPage() {
      return RaisedButton(
        elevation: 8,
        shape: StadiumBorder(),
        color: Color.fromRGBO(255, 195, 0, 1),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          SettingsController.reloadIntroductionPage(context);
        },
        child: Text(
          SettingsManager.mapLanguage["ReloadIntroduction"] != null
              ? SettingsManager.mapLanguage["ReloadIntroduction"]
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
        style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
      ),
    );
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 40.0,
                ),
              ],
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/settings.png"),
              ),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                SettingsManager.mapLanguage["LanguageChanged"] != null
                    ? SettingsManager.mapLanguage["LanguageChanged"]
                    : "",
                style: TextStyle(
                    color: Color.fromRGBO(0, 157, 153, 1), fontSize: 25),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                SettingsManager.mapLanguage["NotificationPushActivated"] != null
                    ? SettingsManager.mapLanguage["NotificationPushActivated"]
                    : "",
                style: TextStyle(
                    color: Color.fromRGBO(0, 157, 153, 1), fontSize: 25),
              ),
              statusPushNotification
            ],
          ),
          SizedBox(
            height: 45,
          ),
          reloadIntroductionPage(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: disconnectButton(),
                width: 350,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
