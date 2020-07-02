import 'package:betsbi/tools/AppBarOffline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppBarOnline.dart';

class AppSearchBar extends StatefulWidget with PreferredSizeWidget {
  final bool isOffline;

  AppSearchBar({this.isOffline = false});

  State<AppSearchBar> createState() =>
      this.isOffline ? AppBarOffline() : AppBarOnline();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
