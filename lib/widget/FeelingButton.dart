import 'package:betsbi/controller/FeelingController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/FlushBarError.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final int idButton;
  final String errorMessage;

  const FeelingButton(this.idButton,this.text, this.iconData, this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FeelingController.sendFeelings(this.idButton).then((isSent) =>
            isSent ?
            FeelingController.redirectionFeelingToHomePage(context)
            : FlushBarError(this.errorMessage).showFlushBar(context)
        );

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
