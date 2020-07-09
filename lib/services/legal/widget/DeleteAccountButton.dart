import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/legal/controller/DataUsePolicyController.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteAccountButton extends StatelessWidget{
  final String userId;
  final String content;


  DeleteAccountButton({@required this.userId, @required this.content});


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Colors.red,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () => showYesOrNoDialog(context: context),
      child: Text(content,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  static showYesOrNoDialog({@required BuildContext context}) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: DefaultTextTitle(title: SettingsManager.mapLanguage["DeleteAccountQuestion"],),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            elevation: 8,
            shape: StadiumBorder(),
            color: Colors.red,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async => await DataUsePolicyController.deleteCurrentAccount(context: context),
            child: Text(SettingsManager.mapLanguage["Yes"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 100),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 45,),
          RaisedButton(
            elevation: 8,
            shape: StadiumBorder(),
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(SettingsManager.mapLanguage["No"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 100),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      actions: [],
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