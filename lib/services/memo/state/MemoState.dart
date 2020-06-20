import 'package:async/async.dart';
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
import 'package:betsbi/tools/MemosWidget.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemosState extends State<MemosPage> with WidgetsBindingObserver {
  List<MemosWidget> list = List<MemosWidget>();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController dueTimeController = TextEditingController();
  AsyncMemoizer _memorizer = AsyncMemoizer();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _memorizer = AsyncMemoizer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }

  getAllMemos() {
    return this._memorizer.runOnce(() async {
      list = await MemosController.getALlMemos(this);
      return list;
    });
  }

  refreshMemosList() async {
    MemosController.getALlMemos(this).then((listMemosWid) {
      setState(() {
        list = listMemosWid;
      });
    });
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
              future: getAllMemos(),
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
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: list[index],
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
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
        isOffLine: this.widget.isOffline,
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(SettingsManager.mapLanguage["Cancel"]),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(SettingsManager.mapLanguage["Submit"]),
      onPressed: () {
        if (this._formKey.currentState.validate()) {
          MemosController.addNewMemoToMemos(titleController.text,
                  dueDateController.text + " " + dueTimeController.text)
              .then(
            (memoId) => this.setState(() {
              list.add(
                MemosWidget(
                  title: titleController.text,
                  dueDate:
                      dueDateController.text + " " + dueTimeController.text,
                  id: memoId,
                  parent: this,
                ),
              );
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
      actions: [okButton, cancelButton],
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
                child: timeFormField(labelAndHint: SettingsManager.mapLanguage["DueTime"]),
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