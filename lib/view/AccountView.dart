import 'package:betsbi/account.dart';
import 'package:betsbi/controller/ContainerController.dart';
import 'package:betsbi/model/AppSearchBar.dart';
import 'package:betsbi/model/BottomNavigationBarFooter.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class AccountView extends State<AccountPage> {
  int _selectedBottomIndex = 1;
  User user = new User(0, 'Antoine Daniel', 'Psychologue', 1);
  final List<int> feelingsPoint = [0, 1, 2, 3, 4, 5, 6];

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
      appBar: AppSearchBar(
          SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : "",
          ContainerController.users),
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
            Container(
              child: Echarts(
                captureAllGestures: true,
                option: '''
                    {
                      title: {
                        subtextStyle: {
                          align: 'center',
                        },
                        text: 'Feelings in the week',
                      },
                      xAxis: {
                        type: 'category',
                        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      },
                      yAxis: {
                        type: 'value'
                      },
                      series: [{
                        data: $feelingsPoint,
                        type: 'line'
                      }]
                    }
                  ''',
              ),
              width: 300,
              height: 250,
            )
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }
}
