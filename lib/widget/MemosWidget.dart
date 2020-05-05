import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemosWidget extends StatefulWidget {
  final String title;
  bool isDone;
  final String dueDate;

  MemosWidget({this.title, this.isDone = false, this.dueDate});

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
            style: TextStyle(fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1)),
          ),
          Text(
            SettingsManager.mapLanguage["DueDate"] +
                " " +
                this.widget.dueDate,
            style: TextStyle(fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1), fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          this.widget.isDone
              ? Text(
                  SettingsManager.mapLanguage["Done"],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
              : RaisedButton(
                  elevation: 8,
                  color: Color.fromRGBO(255, 195, 0, 1),
                  shape: StadiumBorder(
                      side: BorderSide(
                    color: Color.fromRGBO(255, 195, 0, 1),
                  )),
                  onPressed: () {
                    setState(() {
                      this.widget.isDone = true;
                    });
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
