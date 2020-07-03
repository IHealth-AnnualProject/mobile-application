import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/CheckController.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/memo/controller/MemosController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/memo/view/MemosView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultCircleAvatar.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemosState extends State<MemosPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController dueTimeController = TextEditingController();

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
      appBar: AppSearchBar(
        isOffline: this.widget.isOffline,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
            ),
            DefaultCircleAvatar(
              imagePath: "assets/notes.png",
            ),
            SizedBox(
              height: 45,
            ),
            DefaultTextTitle(
              title: SettingsManager.mapLanguage["MemosList"],
            ),
            FutureBuilder(
              future: MemosController.getALlMemos(this),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return WaitingWidget();
                } else {
                  return Column(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: snapshot.data[index],
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ), // T
      floatingActionButton: FloatingActionButton.extended(
        label: Text(SettingsManager.mapLanguage["CreateMemos"]),
        backgroundColor: Color.fromRGBO(0, 157, 153, 1),
        icon: Icon(Icons.add),
        onPressed: () => showAlertDialog(context),
      ), // his trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: 1,
        selectedBottomIndexOnline: null,
        isOffLine: this.widget.isOffline,
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget cancelButton = FlatButton(
      child: Text(SettingsManager.mapLanguage["Cancel"]),
      onPressed: () {
        titleController.clear();
        dueTimeController.clear();
        dueDateController.clear();
        Navigator.pop(context);
      },
    );

    Widget submitButton = FlatButton(
      child: Text(SettingsManager.mapLanguage["Submit"]),
      onPressed: () {
        if (this._formKey.currentState.validate()) {
          MemosController.addNewMemoToMemos(
                  title: titleController.text,
                  dueDate:
                      dueDateController.text + " " + dueTimeController.text)
              .then(
            (memoId) => this.setState(() {
              titleController.clear();
              dueTimeController.clear();
              dueDateController.clear();
              Navigator.of(context).pop();
            }),
          );
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        SettingsManager.mapLanguage["CreateMemos"],
        style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
      ),
      content: formToCreateMemoOnDueDate(),
      actions: [submitButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Form formToCreateMemoOnDueDate() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: memosFormField(
                    labelAndHint: SettingsManager.mapLanguage["Title"],
                    textInputType: TextInputType.text,
                    textEditingController: titleController),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: dateFormField(
                    labelAndHint: SettingsManager.mapLanguage["DueDate"]),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: timeFormField(
                    labelAndHint: SettingsManager.mapLanguage["DueTime"]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField memosFormField(
      {String labelAndHint,
      TextInputType textInputType,
      TextEditingController textEditingController}) {
    return TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      controller: textEditingController,
      keyboardType: textInputType,
      validator: (value) => CheckController.checkField(value),
      decoration: InputDecoration(
          labelText: labelAndHint,
          filled: true,
          fillColor: Colors.white,
          hintText: labelAndHint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
  }

  TextFormField dateFormField({String labelAndHint}) {
    return TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      controller: dueDateController,
      onTap: () => _selectDate(),
      validator: (value) => CheckController.checkField(value),
      decoration: InputDecoration(
          labelText: labelAndHint,
          filled: true,
          fillColor: Colors.white,
          hintText: labelAndHint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
  }

  TextFormField timeFormField({String labelAndHint}) {
    return TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      controller: dueTimeController,
      onTap: () => _selectTime(),
      validator: (value) => CheckController.checkField(value),
      decoration: InputDecoration(
          labelText: labelAndHint,
          filled: true,
          fillColor: Colors.white,
          hintText: labelAndHint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null)
      setState(() =>
          dueDateController.text = DateFormat("dd-MM-yyyy").format(picked));
  }

  Future _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    DateTime now = DateTime.now();
    DateTime timePicked =
        DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    if (picked != null)
      setState(() =>
          dueTimeController.text = DateFormat("HH:mm").format(timePicked));
  }
}
