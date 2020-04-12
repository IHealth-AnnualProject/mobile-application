import 'package:betsbi/service/Language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../register.dart';

class RegisterView extends State<RegisterPage> {
  List<bool> _isSelected = [true, false];

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
    final username = TextField(
      obscureText: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["UsernameText"] != null ? Language.mapLanguage["UsernameText"] : "",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final password = TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["PasswordText"] != null ? Language.mapLanguage["PasswordText"] : "",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final confirmPassword = TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText:
          Language.mapLanguage["ConfirmPassword"] != null ? Language.mapLanguage["ConfirmPassword"] : "",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final email = TextField(
      obscureText: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["EmailText"] != null ? Language.mapLanguage["EmailText"] : "",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final statusUser = ToggleButtons(
      children: <Widget>[
        Text(Language.mapLanguage["UserChoice"] != null ? Language.mapLanguage["UserChoice"] : ""),
        Text(Language.mapLanguage["PsyChoice"] != null ? Language.mapLanguage["PsyChoice"] : "")
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
          buttonIndex < _isSelected.length;
          buttonIndex++) {
            if (buttonIndex == index) {
              _isSelected[buttonIndex] = true;
            } else {
              _isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: _isSelected,
    );
    final doneButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(16.0),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text(
          Language.mapLanguage["DoneButton"] != null ? Language.mapLanguage["DoneButton"] : "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 228, 228, 1),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                      height: 20,
                    ),
                    Container(child: username, width: 350),
                    SizedBox(
                      height: 45,
                    ),
                    Container(child: email, width: 350),
                    SizedBox(
                      height: 45,
                    ),
                    Container(child: password, width: 350),
                    SizedBox(
                      height: 45,
                    ),
                    Container(child: confirmPassword, width: 350),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      Language.mapLanguage["CheckBoxPsy"] != null ? Language.mapLanguage["CheckBoxPsy"] : "",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    statusUser,
                    SizedBox(
                      height: 20,
                    ),
                    Container(child: doneButton, width: 350),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}