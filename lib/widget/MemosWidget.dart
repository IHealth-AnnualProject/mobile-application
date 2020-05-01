import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemosWidget extends StatefulWidget {
  final String title;
  bool isDone;

  MemosWidget({this.title, this.isDone});

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
        children: <Widget>[
          Text(
            this.widget.title,
            style: TextStyle(fontSize: 25, color: Colors.cyan),
          ),
          SizedBox(width: 20,),
          this.widget.isDone
              ? Text(
                  SettingsManager.mapLanguage["Done"],
                  style: TextStyle(color: Colors.lime[700], fontSize: 25),
                )
              : RaisedButton(
                  elevation: 8,
                  color: Colors.lime[700],
                  shape: StadiumBorder(
                      side: BorderSide(
                    color: Color.fromRGBO(228, 228, 228, 1),
                  )),
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
