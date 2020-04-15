import 'package:betsbi/feelings.dart';
import 'package:betsbi/model/FinalButton.dart';
import 'package:betsbi/service/Language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../register.dart';

class RegisterView extends State<RegisterPage> {
  List<bool> _isSelected = [true, false];
  final _formKey = GlobalKey<FormState>();

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
      textAlign: TextAlign.left,
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
      textAlign: TextAlign.left,
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
    final confirmPassword = TextFormField(
      obscureText: true,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value.isEmpty) {
          return Language.mapLanguage["EnterText"] != null
              ? Language.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: Language.mapLanguage["ConfirmPassword"] != null
              ? Language.mapLanguage["ConfirmPassword"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["ConfirmPassword"] != null
              ? Language.mapLanguage["ConfirmPassword"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final email = TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value.isEmpty) {
          return Language.mapLanguage["EnterText"] != null
              ? Language.mapLanguage["EnterText"]
              : "";
        }
        if (!value.contains('@'))
          return Language.mapLanguage["EmailErrorText"] != null
              ? Language.mapLanguage["EmailErrorText"]
              : "";
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: Language.mapLanguage["EmailText"] != null
              ? Language.mapLanguage["EmailText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["EmailText"] != null
              ? Language.mapLanguage["EmailText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final statusUser = ToggleButtons(
      children: <Widget>[
        Text(Language.mapLanguage["UserChoice"] != null
            ? Language.mapLanguage["UserChoice"]
            : ""),
        Text(Language.mapLanguage["PsyChoice"] != null
            ? Language.mapLanguage["PsyChoice"]
            : "")
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
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
                            Language.mapLanguage["CheckBoxPsy"] != null
                                ? Language.mapLanguage["CheckBoxPsy"]
                                : "",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          statusUser,
                          SizedBox(
                            height: 20,
                          ),
                          Container(child: FinalButton(Language.mapLanguage["DoneButton"] != null
                              ? Language.mapLanguage["DoneButton"]
                              : "", Feelings(), _formKey,
                              Language.mapLanguage["RegisterSent"] != null
                                  ? Language.mapLanguage["RegisterSent"]
                                  : ""), width: 350),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
