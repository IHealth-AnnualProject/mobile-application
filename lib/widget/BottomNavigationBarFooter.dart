import 'package:betsbi/controller/BottomNavigationController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarFooter extends StatefulWidget {
  final int selectedBottomIndex;

  BottomNavigationBarFooter(this.selectedBottomIndex);

  @override
  _BottomNavigationBarFooterState createState() =>
      _BottomNavigationBarFooterState();
}

class _BottomNavigationBarFooterState extends State<BottomNavigationBarFooter> {

  BottomNavigationBar bottomNavigationBarWithoutCurrentIndex(){
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(SettingsManager.mapLanguage["HomeFooter"] != null
                ? SettingsManager.mapLanguage["HomeFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(SettingsManager.mapLanguage["AccountFooter"] != null
                ? SettingsManager.mapLanguage["AccountFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(SettingsManager.mapLanguage["ChatFooter"] != null
                ? SettingsManager.mapLanguage["ChatFooter"]
                : ""),
          ),
        ],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.onBottomTapped(this.widget.selectedBottomIndex,index, context);
          });
        });
  }

  BottomNavigationBar bottomNavigationBarWithCurrentIndex(){
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(SettingsManager.mapLanguage["HomeFooter"] != null
                ? SettingsManager.mapLanguage["HomeFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(SettingsManager.mapLanguage["AccountFooter"] != null
                ? SettingsManager.mapLanguage["AccountFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(SettingsManager.mapLanguage["ChatFooter"] != null
                ? SettingsManager.mapLanguage["ChatFooter"]
                : ""),
          ),
        ],
        currentIndex: this.widget.selectedBottomIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.onBottomTapped(this.widget.selectedBottomIndex,index, context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if(this.widget.selectedBottomIndex == null)
      return bottomNavigationBarWithoutCurrentIndex();
    else
      return bottomNavigationBarWithCurrentIndex();
  }
}
