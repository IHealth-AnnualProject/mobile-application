import 'package:betsbi/manager/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NothingToShow extends StatelessWidget {
  final Widget destination;

  NothingToShow({@required this.destination});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        SettingsManager.mapLanguage["NothingToShowAndClick"],
        textAlign: TextAlign.center,
        style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 20),
      ),
      onTap: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ),
        (Route<dynamic> route) => false,
      ),
    );
  }
}
