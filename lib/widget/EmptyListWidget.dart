import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';

class EmptyListWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            SettingsManager.mapLanguage["NothingToShow"],
            style: TextStyle(fontSize: 40),
          ),
          Image.asset("assets/emptyList.png"),
        ],
      ),
    );
  }

}