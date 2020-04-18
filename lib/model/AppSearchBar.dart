import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SearchApp.dart';

class AppSearchBar extends StatefulWidget with PreferredSizeWidget {
  final users;
  final String title;

  AppSearchBar(this.title, this.users);

  @override
  _AppSearchBarState createState() => _AppSearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(104, 79, 37, 0.8),
      title: Text(this.widget.title),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: DataSearch(this.widget.users));
            }),
        /*IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),*/
      ],
    );
  }
}
