import 'package:async/async.dart';
import 'package:betsbi/controller/LoginController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      MaterialApp(
        theme: ThemeData(fontFamily: 'PoetsenOne'),
        home: MainPage(),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainView createState() => new _MainView();
}

class _MainView extends State<MainPage> {
  Widget destination;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  _findRedirection() {
    return this._memoizer.runOnce(() async {
      await SettingsManager.languageStarted().then((r) async {
        await TokenController.checkTokenValidity().then((tokenValid) =>
            tokenValid
                ? destination = LoginController.redirectionLogin()
                : destination = LoginPage());
      });
      return destination;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 228, 228, 1),
        body: FutureBuilder(
          future: _findRedirection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    "Welcome to BetsBi",
                    style: TextStyle(color: Colors.cyan[300], fontSize: 40),
                  ),
                  SizedBox(
                    height: 150,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(104, 79, 37, 0.8)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else {
              // data loaded:
              return destination;
            }
          },
        ));
  }
}
