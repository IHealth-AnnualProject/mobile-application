import 'package:betsbi/services/feeling/controller/FeelingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final int idButton;
  final String errorMessage;
  final Color colorButton;

  const FeelingButton(
      {this.idButton,
      this.text,
      this.iconData,
      this.errorMessage,
      this.colorButton});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async =>
          await FeelingController.sendFeelings(value : this.idButton, context : context),
      color: this.colorButton,
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
