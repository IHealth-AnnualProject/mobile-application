import 'package:betsbi/controller/FeelingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingButton extends StatelessWidget {
  final String text;
  final IconData iconData;

  const FeelingButton(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FeelingController.redirection(context);
      },
      color: Color.fromRGBO(104, 79, 37, 0.8),
      textColor: Colors.white,
      child: Icon(
        this.iconData,
        size: MediaQuery.of(context).size.width * 0.25,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    );
  }
}
