import 'package:async/async.dart';
import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/MemosController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/state/IMemoViewState.dart';
import 'package:betsbi/view/MemosView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultCircleAvatar.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/MemosWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemoViewOfflineState extends State<MemosPage> with IMemoViewState {
  List<MemosWidget> list = List<MemosWidget>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  bool canCreate = false;
  AsyncMemoizer _memorizer = AsyncMemoizer();
  MemosWidget memosWidget;

  @override
  void dispose() {
    super.dispose();
    _memorizer = AsyncMemoizer();
  }

  @override
  void initState() {
    super.initState();
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }

  @override
  getAllMemos() {
    return this._memorizer.runOnce(() async {
      list = await MemosController.getALlMemos(this);
      return list;
    });
  }

  @override
  refreshMemosList() async {
    MemosController.getALlMemos(this).then((listMemosWid) {
      setState(() {
        list = listMemosWid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(
        isOffline: true,
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
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
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
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        1,
        isOffLine: true,
      ),
    );
  }

  showAlertDialog(BuildContext context) {
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
          MemosController.addNewMemoToMemos(
                  titleController.text, dueDateController.text)
              .then(
            (memoId) => this.setState(() {
              list.add(
                new MemosWidget(
                  title: titleController.text,
                  dueDate: dueDateController.text,
                  id: memoId,
                  parent: this,
                ),
              );
              canCreate = false;
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
          Row(
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
                    labelAndHint: SettingsManager.mapLanguage["DueDate"],
                    textEditingController: titleController),
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

  TextFormField dateFormField(
      {String labelAndHint, TextEditingController textEditingController}) {
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

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1996),
        lastDate: new DateTime(DateTime.now().year + 2));
    if (picked != null)
      setState(
          () => dueDateController.text = DateFormat.yMMMd().format(picked));
  }
}
