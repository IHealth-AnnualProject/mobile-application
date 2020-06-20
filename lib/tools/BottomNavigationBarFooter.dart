import 'package:betsbi/tools/BottomNavigationBarFooterState.dart';
import 'package:betsbi/tools/BottomNavigationOfflineBarFooter.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigationBarFooter extends StatefulWidget {
  final int selectedBottomIndexOnline;
  final int selectedBottomIndexOffLine;
  final bool isOffLine;

  //todo make 2 different constructors

  BottomNavigationBarFooter({this.selectedBottomIndexOnline, this.selectedBottomIndexOffLine, this.isOffLine = false});

  @override
  State<BottomNavigationBarFooter> createState() => this.isOffLine ? BottomNavigationOfflineBarFooterState() :
      BottomNavigationBarFooterState();
}