import 'package:betsbi/controller/ContainerController.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/widget/AccountInformation.dart';
import 'package:betsbi/widget/AccountTrace.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  AccountView createState() => AccountView();
}

class AccountView extends State<AccountPage> with TickerProviderStateMixin {
  int _selectedBottomIndex = 1;
  User user = new User(0, 'Antoine Daniel', 'Psychologue', 1);
  bool differentView = true;
  UserProfile userProfile = new UserProfile.defaultConstructor();




  @override
  void dispose() {
    super.dispose();
  }

  void userInformation() async {
    await userProfile.getUserProfile();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    userInformation();
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final titleAccount = Text(
      userProfile.username + " lv." + user.level.toString(),
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(width: 150,child :changeStateButton(id :1, buttonContent : "Information")),
                  Container(width: 150,child :changeStateButton(id :2, buttonContent : "Trace")),
                ],
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
                  color: Color.fromRGBO(104, 79, 37, 0.8),
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
              differentView ? AccountInformation() : AccountTrace(),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }

  RaisedButton changeStateButton(
      {int id,String buttonContent}) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
          switch(id){
            case 1 :
              setState(() {
                differentView = true;
              });
              break;
            case 2 :
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
}
