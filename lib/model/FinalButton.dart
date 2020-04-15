import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalButton extends StatelessWidget {
  final String content;
  final StatelessWidget destination;
  final _formKey;
  final String barContent;

  FinalButton(this.content, this.destination, this._formKey, this.barContent);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        if (this._formKey.currentState.validate()) {
          Flushbar(
            icon: Icon(
              Icons.done_outline,
              color: Colors.yellow,
            ),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            message: this.barContent,
            duration: Duration(seconds: 1),
          )..show(context).then((r) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => this.destination)));
        }
      },
      child: Text(
        this.content,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
