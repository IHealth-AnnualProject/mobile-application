import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/CheckController.dart';
import 'package:betsbi/services/error/controller/ErrorController.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/error/view/ErrorView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:betsbi/tools/TextFormFieldCustomBetsBi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorState extends State<ErrorPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleEditingController = new TextEditingController();
  TextEditingController descriptionEditingController =
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
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
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
                DefaultTextTitle(
                  title: SettingsManager.mapLanguage["ErrorTitle"],
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
                        child: SubmitButton(
                          content: SettingsManager.mapLanguage["Submit"],
                          onPressedFunction: () => ErrorController.sendError(
                            context: context,
                            name: titleEditingController.text,
                            description: descriptionEditingController.text,
                          ).whenComplete(() => this.setState(() {
                                titleEditingController =
                                    new TextEditingController();
                                descriptionEditingController =
                                    new TextEditingController();
                              })),
                        ),
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
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
    );
  }
}
