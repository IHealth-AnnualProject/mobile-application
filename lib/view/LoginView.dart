import 'package:betsbi/feelings.dart';
import 'package:betsbi/service/Language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login.dart';
import '../register.dart';

class LoginView extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _setLanguage() async {
    await Language.setLanguage();
    setState(() {});
  }

  void instanciateLanguage() async {
    await Language.languageStarted();
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

    final username = TextFormField(
      obscureText: false,
      textAlign: TextAlign.center,
      validator: (value) {
        if (value.isEmpty) {
          return Language.mapLanguage["EnterText"] != null
              ? Language.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: Language.mapLanguage["UsernameText"] != null
              ? Language.mapLanguage["UsernameText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["UsernameText"] != null
              ? Language.mapLanguage["UsernameText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final password = TextFormField(
      obscureText: true,
      textAlign: TextAlign.center,
      validator: (value) {
        if (value.isEmpty) {
          return Language.mapLanguage["EnterText"] != null
              ? Language.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: Language.mapLanguage["PasswordText"] != null
              ? Language.mapLanguage["PasswordText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["PasswordText"] != null
              ? Language.mapLanguage["PasswordText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(16.0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(104, 79, 37, 0.8),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Feelings()));
          }
        },
        child: Text(
          Language.mapLanguage["LoginText"] != null
              ? Language.mapLanguage["LoginText"]
              : "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    final language = InkWell(
      onTap: () {
        _setLanguage();
      },
      child: new Text(
        Language.cfg.getString("language") != null
            ? Language.cfg.getString("language")
            : "",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
    final forgotPassword = InkWell(
        onTap: () {
          Language.setLanguage();
        },
        child: new Text(
          Language.mapLanguage["ForgotPassword"] != null
              ? Language.mapLanguage["ForgotPassword"]
              : "",
          textAlign: TextAlign.center,
        ));
    final signUp = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
          //_setLanguage(cfg.getString("language"));
        },
        child: new Text(
          Language.mapLanguage["SignUp"] != null
              ? Language.mapLanguage["SignUp"]
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
                          forgotPassword,
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                            width: 350.0,
                            child: loginButton,
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
                                Language.mapLanguage["NoAccount"] != null
                                    ? Language.mapLanguage["NoAccount"]
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
}