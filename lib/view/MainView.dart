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

  Future<Widget> findRedirection() async {
    SettingsManager.languageStarted().then((r) {
      TokenController.checkTokenValidity().then((tokenValid) => tokenValid
          ? destination = LoginController.redirectionLogin()
          : destination = LoginPage());
    });
    return destination;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder<Widget>(
      future: findRedirection(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (!snapshot.hasData) {
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
