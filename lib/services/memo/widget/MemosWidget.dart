import 'package:betsbi/services/memo/controller/MemosController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/memo/state/MemoState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemosWidget extends StatefulWidget {
  final String title;
  final String dueDate;
  final int id;
  final MemosState parent;

  MemosWidget({@required this.title, @required this.dueDate, @required this.id, @required this.parent});

  @override
  _MemosWidgetState createState() => _MemosWidgetState();
}

class _MemosWidgetState extends State<MemosWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        children: <Widget>[
          Text(
            this.widget.title,
            style:
                TextStyle(fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1)),
          ),
          Text(
            SettingsManager.mapLanguage["DueDate"] + " " + this.widget.dueDate,
            style: TextStyle(
                fontSize: 25,
                color: Color.fromRGBO(0, 157, 153, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          RaisedButton(
            elevation: 8,
            color: Color.fromRGBO(255, 195, 0, 1),
            shape: StadiumBorder(
                side: BorderSide(
              color: Color.fromRGBO(255, 195, 0, 1),
            )),
            onPressed: () {
              MemosController.deleteMemoFromMemos(this.widget.id).then(
                (value) => this.widget.parent.setState(() { }),
              );
            },
            child: Text(
              SettingsManager.mapLanguage["Done"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 100),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 3,
            color: Colors.cyan,
            height: 10,
          ),
        ],
      ),
    );
  }
}
