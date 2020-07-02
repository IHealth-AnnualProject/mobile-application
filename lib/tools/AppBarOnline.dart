import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/SearchBarController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppSearchBar.dart';
import 'SearchApp.dart';

class AppBarOnline extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color.fromRGBO(0, 116, 113, 1),
      title: Text(SettingsManager.mapLanguage["SearchContainer"]),
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(
                  context,
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
          icon: SearchBarController.getCurrentIconSearchBarCategory(),
          onSelected: (choice) => this.setState(() {
            SearchBarController.searchCategory = choice;
          }),
          itemBuilder: (BuildContext context) {
            return SearchBarController.searchChoicesCategory
                .map((String choice) {
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
