import 'package:betsbi/controller/FeelingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingButton extends StatelessWidget{
  final String text;

  const FeelingButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(16.0),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FeelingController.redirection(context);
        },
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}