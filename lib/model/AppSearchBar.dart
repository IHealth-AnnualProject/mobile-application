import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SearchApp.dart';

class AppSearchBar extends StatelessWidget with PreferredSizeWidget {
  final users;
  final String title;

  AppSearchBar(this.title, this.users);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      backgroundColor: Color.fromRGBO(104, 79, 37, 0.8),
      title: Text(this.title),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(users));
            }),
        /* IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),*/
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}