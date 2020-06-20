import 'package:async/async.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/introduction/view/IntroductionView.dart';
import 'package:betsbi/services/MainView.dart';
import 'package:betsbi/services/registrationAndLogin/controller/LoginController.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global/controller/TokenController.dart';

class MainState extends State<MainPage> {
  Widget destination;
  AsyncMemoizer _memorizer = AsyncMemoizer();

  _instanciteConfigurationPropertiesAndLaguageAndFindRedirection() {
    return this._memorizer.runOnce(() async {
      await SettingsManager.instanciateConfigurationAndLoadLanguage()
          .then((r) async {
        await TokenController.checkTokenValidity(context).then(
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
    this._memorizer = AsyncMemoizer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _instanciteConfigurationPropertiesAndLaguageAndFindRedirection(),
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
            return destination;
          }
        },
      ),
    );
  }
}
