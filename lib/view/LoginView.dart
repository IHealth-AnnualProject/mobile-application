import 'package:betsbi/controller/LoginController.dart';
import 'package:betsbi/widget/ForgotPassword.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import 'RegisterView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalConfiguration()
      .loadFromPath("assets/cfg/settings.json")
      .then((r) => runApp(MaterialApp(home: LoginPage())));
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginView createState() => LoginView();
}

class LoginView extends State<LoginPage> {
  bool loging;
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void _setLanguage() {
    SettingsManager.setLanguage().then((r) => setState(() {}));
  }

  void instanciateLanguage() {
    SettingsManager.languageStarted().then((r) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    instanciateLanguage();

    RaisedButton loginButton() {
      return RaisedButton(
        elevation: 8,
        shape: StadiumBorder(),
        color: Color.fromRGBO(104, 79, 37, 0.8),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (this._formKey.currentState.validate()) {
            loging = await LoginController.login(
                userNameController.text, passwordController.text);
            if (loging)
              loginFlushBar(
                  Icon(
                    Icons.done_outline,
                    color: Colors.yellow,
                  ),
                  SettingsManager.mapLanguage["ConnectSent"] != null
                      ? SettingsManager.mapLanguage["ConnectSent"]
                      : "")
                ..show(context)
                    .then((r) => LoginController.redirection(context));
            else
              loginFlushBar(
                      Icon(
                        Icons.not_interested,
                        color: Colors.red,
                      ),
                      SettingsManager.mapLanguage["InformationWrong"] != null
                          ? SettingsManager.mapLanguage["InformationWrong"]
                          : "")
                  .show(context);
          }
        },
        child: Text(
          SettingsManager.mapLanguage["LoginText"] != null
              ? SettingsManager.mapLanguage["LoginText"]
              : "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
      );
    }
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final username = TextFormField(
      obscureText: false,
      controller: userNameController,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["UsernameText"] != null
              ? SettingsManager.mapLanguage["UsernameText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["UsernameText"] != null
              ? SettingsManager.mapLanguage["UsernameText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final password = TextFormField(
      obscureText: true,
      controller: passwordController,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["PasswordText"] != null
              ? SettingsManager.mapLanguage["PasswordText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["PasswordText"] != null
              ? SettingsManager.mapLanguage["PasswordText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final language = InkWell(
      onTap: () {
        _setLanguage();
      },
      child: new Text(
        SettingsManager.language != null ? SettingsManager.language : "",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
    final signUp = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
          //_setLanguage(cfg.getString("language"));
        },
        child: new Text(
          SettingsManager.mapLanguage["SignUp"] != null
              ? SettingsManager.mapLanguage["SignUp"]
              : "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ));
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 228, 228, 1),
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
                            child: username,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 350.0,
                            child: password,
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          //forgotPassword,
                          ForgotPassword(
                              SettingsManager.mapLanguage["ForgotPassword"] !=
                                      null
                                  ? SettingsManager
                                      .mapLanguage["ForgotPassword"]
                                  : "",
                              "bidule",
                              Icons.message),
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                            width: 350.0,
                            child: loginButton(),
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
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      language,
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Text(
                                SettingsManager.mapLanguage["NoAccount"] != null
                                    ? SettingsManager.mapLanguage["NoAccount"]
                                    : "",
                                style: TextStyle(color: Colors.white)),
                            signUp
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  Flushbar loginFlushBar(Icon icon, String message) {
    return Flushbar(
      icon: icon,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      message: message,
      duration: Duration(seconds: 1),
    );
  }
}
