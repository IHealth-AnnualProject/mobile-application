import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/CheckController.dart';
import 'package:betsbi/services/memo/view/MemosView.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/registrationAndLogin/controller/LoginController.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:betsbi/services/registrationAndLogin/view/RegisterView.dart';
import 'package:betsbi/services/registrationAndLogin/widget/ForgotPassword.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:betsbi/tools/TextFormFieldCustomBetsBi.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_up/swipe_up.dart';

class LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    HistoricalManager.historical = new List<Widget>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeUp(
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 350.0,
                            child: TextFormFieldCustomBetsBi(
                              obscureText: false,
                              controller: userNameController,
                              textAlign: TextAlign.left,
                              icon: Icon(Icons.person),
                              validator: (value) =>
                                  CheckController.checkField(value),
                              labelText:
                                  SettingsManager.mapLanguage["UsernameText"],
                              filled: true,
                              fillColor: Colors.white,
                              hintText:
                                  SettingsManager.mapLanguage["UsernameText"],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 350.0,
                            child: TextFormFieldCustomBetsBi(
                              obscureText: true,
                              controller: passwordController,
                              icon: Icon(Icons.lock),
                              child: true,
                              textAlign: TextAlign.left,
                              validator: (value) =>
                                  CheckController.checkField(value),
                              labelText:
                                  SettingsManager.mapLanguage["PasswordText"],
                              filled: true,
                              fillColor: Colors.white,
                              hintText:
                                  SettingsManager.mapLanguage["PasswordText"],
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          //forgotPassword,
                          ForgotPassword(
                              message: SettingsManager
                                          .mapLanguage["ForgotPassword"] !=
                                      null
                                  ? SettingsManager
                                      .mapLanguage["ForgotPassword"]
                                  : "",
                              icons: Icons.message),
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                            width: 350.0,
                            child: SubmitButton(
                              content: SettingsManager.mapLanguage["LoginText"],
                              onPressedFunction: () async {
                                if (this._formKey.currentState.validate()) {
                                  await LoginController.login( username :
                                      userNameController.text, password :
                                      passwordController.text, context :
                                      context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () => SettingsManager.setLanguage()
                            .then((r) => setState(() {})),
                        child: new Text(
                          SettingsManager.applicationProperties.getLanguage() !=
                                  null
                              ? SettingsManager.applicationProperties
                                  .getLanguage()
                              : "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 157, 153, 1),
                              fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Text(
                                SettingsManager.mapLanguage["NoAccount"] != null
                                    ? SettingsManager.mapLanguage["NoAccount"]
                                    : "",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 157, 153, 1),
                                    fontSize: 17)),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              ),
                              child: new Text(
                                SettingsManager.mapLanguage["SignUp"] != null
                                    ? SettingsManager.mapLanguage["SignUp"]
                                    : "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 157, 153, 1),
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
        child: Material(
          color: Colors.transparent,
          child: Text(
            SettingsManager.mapLanguage["OfflineMode"],
            style: TextStyle(
              color: Color.fromRGBO(0, 157, 153, 1),
            ),
          ),
        ),
        onSwipe: () => offlineChoiceFlushBar().show(context),
      ),
    );
  }

  Flushbar offlineChoiceFlushBar() {
    return Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      title: SettingsManager.mapLanguage["OfflineMode"],
      message: SettingsManager.mapLanguage["OfflineContent"],
      mainButton: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemosPage(
                isOffline: true,
              ),
            ),
          ); // result = true
        },
        child: Text(
          "GO",
          style: TextStyle(color: Colors.amber),
        ),
      ),
      duration: Duration(seconds: 2),
    );
  }
}
