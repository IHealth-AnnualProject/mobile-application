import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SearchApp.dart';

class AppSearchBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  TabController tabController;

  AppSearchBar.appSearchBarNormal({this.title});

  State<AppSearchBar> createState() {
      return _AppSearchBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(0, 116, 113, 1),
      title: Text(this.widget.title),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: DataSearch());
            }),
      ],
    );
  }
}