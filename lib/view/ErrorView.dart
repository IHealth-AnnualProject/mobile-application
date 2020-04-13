import 'package:betsbi/error.dart';
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
      textAlign: TextAlign.left,
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
          filled: true,
          fillColor: Colors.white,
          hintText: "Description",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final sendError = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(16.0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(104, 79, 37, 0.8),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
        },
        child: Text(
          Language.mapLanguage["Submit"] != null
              ? Language.mapLanguage["Submit"]
              : "",
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
                            child: sendError,
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
