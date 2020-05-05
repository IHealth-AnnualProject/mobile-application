import 'package:betsbi/controller/QuestController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestWidget extends StatefulWidget {
  final String title;
  bool isDone;
  final String questSate;
  final String description;
  int gainExperience;

  QuestWidget(
      {this.title, this.isDone = false, this.questSate, this.description}) {
    this.gainExperience =
        QuestController.generateGainAccordingToState(this.questSate);
  }

  @override
  _QuestWidgetState createState() => _QuestWidgetState();
}

class _QuestWidgetState extends State<QuestWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      children: <Widget>[
        Text(
          this.widget.title,
          style: TextStyle(fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1)),
        ),
        Text(
          this.widget.questSate,
          style: TextStyle(fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1)),
        ),
        SizedBox(
          width: 20,
        ),
        this.widget.isDone
            ? Text(
                SettingsManager.mapLanguage["Done"],
                style: TextStyle(color: Color.fromRGBO(255, 195, 0, 1), fontSize: 25),
              )
            : RaisedButton(
                elevation: 8,
                color: Color.fromRGBO(255, 195, 0, 1),
                shape: StadiumBorder(
                    side: BorderSide(
                  color: Color.fromRGBO(228, 228, 228, 1),
                )),
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  showAlertDialog(context);
                  setState(() {
                    this.widget.isDone = true;
                  });
                },
                child: Text(
                  SettingsManager.mapLanguage["Done"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 100),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Image.asset("assets/congrats.gif"),
      ),
      content: Text.rich(
        TextSpan(
          text: SettingsManager.mapLanguage["CongratsBegin"],
          style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 17),
          children: [
            TextSpan(
              text: this.widget.gainExperience.toString(),
              style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontWeight: FontWeight.bold, fontSize: 17),
            ),
            TextSpan(
              text: SettingsManager.mapLanguage["CongratsEnd"],
              style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 17),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
