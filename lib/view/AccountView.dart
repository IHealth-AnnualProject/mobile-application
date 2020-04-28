import 'package:betsbi/controller/ContainerController.dart';
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
  TabController _tabController;
  bool differentView = true;

  void instanciateLanguage() {
    SettingsManager.languageStarted().then((r) => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    instanciateLanguage();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 1);
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final titleAccount = Text(
      user.name + " lv." + user.level.toString(),
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
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
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }
}
