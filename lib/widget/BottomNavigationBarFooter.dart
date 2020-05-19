import 'package:betsbi/state/BottomNavigationBarFooter.dart';
import 'package:betsbi/state/BottomNavigationOfflineBarFooter.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigationBarFooter extends StatefulWidget {
  final int selectedBottomIndex;
  final bool isOffLine;

  BottomNavigationBarFooter(this.selectedBottomIndex, {this.isOffLine = false});

  @override
  State<BottomNavigationBarFooter> createState() => this.isOffLine ? BottomNavigationOfflineBarFooterState() :
      BottomNavigationBarFooterState();
}