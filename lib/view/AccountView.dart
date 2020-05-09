import 'package:async/async.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/widget/AccountInformation.dart';
import 'package:betsbi/widget/AccountTrace.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final bool isPsy;
  final String userId;
  AccountPage({this.isPsy, @required this.userId, Key key})
      : super(key: key);

  @override
  _AccountView createState() => _AccountView();
}

class _AccountView extends State<AccountPage> with WidgetsBindingObserver {
  int _selectedBottomIndex = 1;
  bool differentView = true;
  bool isReadOnly = false;
  User profile;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!this.widget.isPsy)
      profile = new UserProfile.defaultConstructor();
    else
      profile = new Psychologist.defaultConstructor();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  findUserInformation() {
    return this._memoizer.runOnce(() async {
      await profile.getUserProfile(userID: this.widget.userId);
      setState(() {});
      return profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final titleAccount = Text(
      profile.username + " lv.1",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
    );
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
        title: SettingsManager.mapLanguage["SearchContainer"] != null
            ? SettingsManager.mapLanguage["SearchContainer"]
            : "",
      ),
      body: FutureBuilder(
        future: findUserInformation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  accountButton(),
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
                        image: AssetImage("assets/user.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  titleAccount,
                  SizedBox(
                    height: 45,
                  ),
                  differentView
                      ? AccountInformation(
                          profileID: profile.profileId,
                          isReadOnly: isReadOnly,
                          isPsy: this.widget.isPsy,
                        )
                      : AccountTrace(
                          profileID: profile.profileId,
                        ),
                ],
              ),
            );
          }
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }

  RaisedButton changeStateButton({int id, String buttonContent, bool colorOn}) {
    return RaisedButton(
      elevation: 8,
      color: colorOn ? Colors.teal[700] : Colors.teal,
      shape: RoundedRectangleBorder(
          side: BorderSide(
        color: Color.fromRGBO(228, 228, 228, 1),
      )),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        switch (id) {
          case 1:
            setState(() {
              differentView = true;
            });
            break;
          case 2:
            setState(() {
              differentView = false;
            });
            break;
        }
      },
      child: Text(
        buttonContent,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Row accountButton() {
    Row row;
    if (SettingsManager.isPsy == "false" && this.widget.userId != SettingsManager.currentId) {
      isReadOnly = true;
      row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              child: changeStateButton(
                  id: 1, buttonContent: "Information", colorOn: differentView),),
        ],
      );
    }
    if(SettingsManager.isPsy == "true" && this.widget.userId != SettingsManager.currentId) {
      isReadOnly = true;
      row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: changeStateButton(
                  id: 1, buttonContent: "Information", colorOn: differentView)),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: changeStateButton(
                  id: 2,
                  buttonContent: SettingsManager.mapLanguage["Trace"],
                  colorOn: !differentView)),
        ],
      );
    }
    if (SettingsManager.isPsy == "false" && this.widget.userId == SettingsManager.currentId) {
      isReadOnly = false;
      row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: changeStateButton(
                  id: 1, buttonContent: "Information", colorOn: differentView),),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: changeStateButton(
                  id: 2,
                  buttonContent: SettingsManager.mapLanguage["Trace"],
                  colorOn: !differentView),),
        ],
      );
    }
    if (SettingsManager.isPsy == "true" && this.widget.isPsy == true) {
      SettingsManager.currentId == this.widget.userId ? isReadOnly = false : isReadOnly = true;
      row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 1,
              child: changeStateButton(
                  id: 1, buttonContent: "Information", colorOn: differentView)),
        ],
      );
    }
    return row;
  }
}
