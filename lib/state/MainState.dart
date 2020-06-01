import 'package:async/async.dart';
import 'package:betsbi/controller/LoginController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/IntroductionView.dart';
import 'package:betsbi/view/LoginView.dart';
import 'package:betsbi/view/MainView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainState extends State<MainPage> {
  Widget destination;
  AsyncMemoizer _memoizer = AsyncMemoizer();

  _findRedirection() {
    return this._memoizer.runOnce(() async {
      await SettingsManager.instanciateConfigurationAndLoadLanguage()
          .then((r) async {
        await TokenController.checkTokenValidity(context)
            .then(
              (tokenValid) => tokenValid
                  ? destination = LoginController.redirectionLogin()
                  : SettingsManager.applicationProperties.getFirstEntry() ==
                          'true'
                      ? destination = IntroductionPage(
                          destination: LoginPage(),
                        )
                      : destination = LoginPage(),
            onError: (e) => TokenController.redirectToLoginPage(context));
      });
      return destination;
    });
  }

  @override
  void dispose() {
    this._memoizer = AsyncMemoizer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _findRedirection(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 45,
              ),
              Text(
                "Welcome to BetsBi",
                style: TextStyle(
                    color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
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
