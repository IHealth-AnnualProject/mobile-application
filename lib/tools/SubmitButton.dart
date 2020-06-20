import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget{
  final Function onPressedFunction;
  final String content;


  SubmitButton({this.onPressedFunction, this.content});


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(255, 195, 0, 1),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: this.onPressedFunction,
      child: Text(this.content,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }

}