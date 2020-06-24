import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/SearchBarController.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SearchApp.dart';

class AppBarWithTabs extends StatefulWidget  with PreferredSizeWidget {
  final List<Tab> tabText;

  AppBarWithTabs({this.tabText});

  @override
  State<StatefulWidget> createState() => AppBarWithTabsState();


  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + kBottomNavigationBarHeight);
}

class AppBarWithTabsState extends State<AppBarWithTabs> {


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
      bottom: TabBar(
        tabs: this.widget.tabText,
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
          icon:  SearchBarController.searchCategory == "user" ? Icon(CommunityMaterialIcons.account) : Icon(CommunityMaterialIcons.note),
          onSelected: (choice) => this.setState(() { SearchBarController.searchCategory = choice; }) ,
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
