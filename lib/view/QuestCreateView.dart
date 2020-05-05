import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/FinalButton.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class QuestCreatePage extends StatefulWidget {
  QuestCreatePage({Key key}) : super(key: key);

  @override
  _QuestCreateView createState() => _QuestCreateView();
}

class _QuestCreateView extends State<QuestCreatePage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  List difficulty = ["easy", "normal", "hard"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentDifficulty;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentDifficulty = _dropDownMenuItems[0].value;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity().then((result) {
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

    final titleFeelings = Text(
      SettingsManager.mapLanguage["QuestCreateTitle"] != null
          ? SettingsManager.mapLanguage["QuestCreateTitle"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(0, 157, 153, 1),
          fontWeight: FontWeight.bold,
          fontSize: 40),
    );
    final titleError = TextFormField(
      obscureText: false,
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
          labelText: SettingsManager.mapLanguage["Title"] != null
              ? SettingsManager.mapLanguage["Title"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["Title"] != null
              ? SettingsManager.mapLanguage["Title"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final descriptionError = TextFormField(
      obscureText: false,
      textAlign: TextAlign.start,
      maxLines: 15,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
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
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          SettingsManager.mapLanguage["ChooseDifficulty"],
                          style:
                              TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 17),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _currentDifficulty,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: 350.0,
                      child: FinalButton(
                          content: SettingsManager.mapLanguage["Submit"] != null
                              ? SettingsManager.mapLanguage["Submit"]
                              : "",
                          destination: HomePage(),
                          formKey: _formKey,
                          barContent:
                              SettingsManager.mapLanguage["ErrorSent"] != null
                                  ? SettingsManager.mapLanguage["ErrorSent"]
                                  : ""),
                    ),
                  ],
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ))),
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }

  void changedDropDownItem(String selectedDifficulty) {
    setState(() {
      _currentDifficulty = selectedDifficulty;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String each in difficulty) {
      items.add(new DropdownMenuItem(value: each, child: new Text(each)));
    }
    return items;
  }
}
