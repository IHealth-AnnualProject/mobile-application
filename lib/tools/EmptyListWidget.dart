import 'package:betsbi/manager/SettingsManager.dart';
import 'package:flutter/cupertino.dart';

class EmptyListWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(

            SettingsManager.mapLanguage["NothingToShow"],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
          Image.asset("assets/emptyList.png"),
        ],
      ),
    );
  }

}