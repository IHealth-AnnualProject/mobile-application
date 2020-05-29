import 'package:betsbi/controller/SearchBarController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppSearchBar.dart';
import 'SearchApp.dart';

class AppBarOnline extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(0, 116, 113, 1),
      title: Text(SettingsManager.mapLanguage["SearchContainer"]),
      leading: HistoricalManager.historical.length >= 2
          ? IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Widget destination = HistoricalManager
              .historical[HistoricalManager.historical.length - 2];
          HistoricalManager.historical.removeLast();
          HistoricalManager.historical.removeLast();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => destination,
            ),
                (Route<dynamic> route) => false,
          );
        },
      )
          : Visibility(
        child: Container(),
        visible: false,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: DataSearch(context),
            );
          },
        ),
        PopupMenuButton<String>(
          onSelected: (choice) => SearchBarController.searchCategory = choice,
          itemBuilder: (BuildContext context) {
            return SearchBarController.searchChoicesCategory.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ],
    );
  }
}