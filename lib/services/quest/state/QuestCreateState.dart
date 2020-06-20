import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/CheckController.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/quest/controller/QuestController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';

import 'package:betsbi/services/quest/view/QuestCreateView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:betsbi/tools/TextFormFieldCustomBetsBi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestCreateState extends State<QuestCreatePage>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  List difficulty = ["easy", "normal"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  String _currentDifficulty;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentDifficulty = _dropDownMenuItems[0].value;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              DefaultTextTitle(
                title: SettingsManager.mapLanguage["QuestCreateTitle"],
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
                        textAlign: TextAlign.left,
                        controller: titleController,
                        validator: (value) => CheckController.checkField(value),
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
                        textAlign: TextAlign.left,
                        maxLines: 15,
                        controller: descriptionController,
                        validator: (value) => CheckController.checkField(value),
                        labelText: "Description",
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Description",
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          SettingsManager.mapLanguage["ChooseDifficulty"],
                          style: TextStyle(
                              color: Color.fromRGBO(0, 157, 153, 1),
                              fontSize: 17),
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
                      child: SubmitButton(
                        content: SettingsManager.mapLanguage["Submit"],
                        onPressedFunction: () => checkFormThenCreateQuest(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
    );
  }

  void checkFormThenCreateQuest() async {
    if (_formKey.currentState.validate()) {
      await QuestController.createQuest(
        context: context,
        questTitle: titleController.value.text,
        questDifficulty: _currentDifficulty,
        questDescription: titleController.value.text,
      );
    }
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
