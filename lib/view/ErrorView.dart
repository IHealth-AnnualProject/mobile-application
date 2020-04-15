import 'package:betsbi/error.dart';
import 'package:betsbi/model/FinalButton.dart';
import 'package:betsbi/service/Language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class ErrorView extends State<ErrorPage> {
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

    final titleFeelings = Text(
      Language.mapLanguage["ErrorTitle"] != null
          ? Language.mapLanguage["ErrorTitle"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 100),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
    final titleError = TextFormField(
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
          labelText: Language.mapLanguage["EnterText"] != null
              ? Language.mapLanguage["EnterText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: Language.mapLanguage["Title"] != null
              ? Language.mapLanguage["Title"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final descriptionError = TextFormField(
      obscureText: false,
      textAlign: TextAlign.start,
      maxLines: 25,
      validator: (value) {
        if (value.isEmpty) {
          return Language.mapLanguage["EnterText"] != null
              ? Language.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Description",
          filled: true,
          fillColor: Colors.white,
          hintText: "Description",
          alignLabelWithHint: true,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
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
                  height: 30,
                ),
                titleFeelings,
                SizedBox(
                  height: 45,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 350.0,
                        child: titleError,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350.0,
                        child: descriptionError,
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: 350.0,
                        child: FinalButton(Language.mapLanguage["Submit"] != null
                            ? Language.mapLanguage["Submit"]
                            : "", Home(), _formKey,
                            Language.mapLanguage["ErrorSent"] != null
                                ? Language.mapLanguage["ErrorSent"]
                                : ""),
                      ),
                    ],
                  ),
                ),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ))));
  }
}
