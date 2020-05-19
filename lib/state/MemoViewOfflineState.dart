import 'package:async/async.dart';
import 'package:betsbi/controller/MemosController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/state/IMemoViewState.dart';
import 'package:betsbi/view/MemosView.dart';
import 'package:betsbi/widget/MemosWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemoViewOfflineState extends State<MemosPage> with IMemoViewState {
  List<MemosWidget> list = List<MemosWidget>();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  bool canCreate = false;
  AsyncMemoizer _memoizer = AsyncMemoizer();
  MemosWidget memosWidget;
  Widget currentPage;

  @override
  void dispose() {
    super.dispose();
    _memoizer = AsyncMemoizer();
  }

  @override
  void initState() {
    super.initState();
    HistoricalManager.historical.add(this.widget);
  }

  @override
  getAllMemos() {
    return this._memoizer.runOnce(() async {
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
    final titleMemos = Text(
      SettingsManager.mapLanguage["MemosList"] != null
          ? SettingsManager.mapLanguage["MemosList"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingsManager.mapLanguage["OfflineMode"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 40.0,
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/notes.png"),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleMemos,
            FutureBuilder(
                future: getAllMemos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                }),
          ],
        ),
      ), // T
      floatingActionButton: FloatingActionButton.extended(
        label: Text(SettingsManager.mapLanguage["CreateMemos"]),
        backgroundColor: Color.fromRGBO(0, 157, 153, 1),
        icon: Icon(Icons.add),
        onPressed: () => showAlertDialog(context),
      ), // his trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: RaisedButton(
        elevation: 8,
        shape: StadiumBorder(),
        color: Color.fromRGBO(255, 195, 0, 1),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          SettingsManager.mapLanguage["LoginPage"],
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
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
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
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
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
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
