import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/ErrorView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/FinalButton.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/TextFormFieldCustomBetsBi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorState extends State<ErrorPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleEditingController =
      new TextEditingController();
  final TextEditingController descriptionEditingController =
      new TextEditingController();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final errorTitle = Text(
      SettingsManager.mapLanguage["ErrorTitle"] != null
          ? SettingsManager.mapLanguage["ErrorTitle"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(0, 157, 153, 1),
          fontWeight: FontWeight.bold,
          fontSize: 40),
    );
    return Scaffold(
      appBar: AppSearchBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                errorTitle,
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
                          textAlign: TextAlign.start,
                          controller: titleEditingController,
                          validator: (value) =>
                              CheckController.checkField(value),
                          labelText: SettingsManager.mapLanguage["Title"],
                          filled: true,
                          fillColor: Colors.white,
                          hintText: SettingsManager.mapLanguage["Title"],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350.0,
                        child: TextFormFieldCustomBetsBi(
                          obscureText: false,
                          textAlign: TextAlign.start,
                          controller: descriptionEditingController,
                          maxLines: 15,
                          validator: (value) =>
                              CheckController.checkField(value),
                          labelText: "Description",
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Description",
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: 350.0,
                        child: FinalButton(
                            content:
                                SettingsManager.mapLanguage["Submit"] != null
                                    ? SettingsManager.mapLanguage["Submit"]
                                    : "",
                            destination: HomePage(),
                            formKey: _formKey,
                            barContent:
                                SettingsManager.mapLanguage["ErrorSent"] != null
                                    ? SettingsManager.mapLanguage["ErrorSent"]
                                    : ""),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
