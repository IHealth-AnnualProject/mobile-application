import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/ReportController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/ReportView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/SubmitButton.dart';
import 'package:betsbi/widget/TextFormFieldCustomBetsBi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportState extends State<ReportView> with WidgetsBindingObserver {
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
                  title: SettingsManager.mapLanguage["YouWithToReport"] +
                      " " +
                      this.widget.userName,
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
                          onPressedFunction: () => ReportController.sendReport(
                                  context: context,
                                  description:
                                      descriptionEditingController.text,
                                  title: titleEditingController.text,
                                  toUserId: this.widget.userId),
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