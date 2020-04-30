import 'package:async/async.dart';
import 'package:betsbi/controller/LoginController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginView.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  MainState createState() => new MainState(); // TODO: implement createState
}

class MainState extends State<Main> {
  Widget destination;
  final AsyncMemoizer _memoizer = AsyncMemoizer();


  findRedirection() {
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
        body: FutureBuilder(
      future: findRedirection(),
      builder: (context,  snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text("Welcome to BetsBi"),
              CircularProgressIndicator(),
            ],
          ));
        } else {
          // data loaded:
          return destination;
        }
      },
    ));
  }
}
