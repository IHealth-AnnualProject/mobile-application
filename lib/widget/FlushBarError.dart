import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlushBarError extends StatelessWidget {
  final String errorContent;

  FlushBarError(this.errorContent);

  Flushbar flushbar(){
    return Flushbar(
        icon: Icon(
        Icons.not_interested,
        color: Colors.red,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    message: this.errorContent,
    duration: Duration(seconds: 1));
  }

  void showFlushBar(BuildContext context)
  {
    flushbar().show(context);
  }

  @override
  Widget build(BuildContext context) {
    return flushbar();
  }

}