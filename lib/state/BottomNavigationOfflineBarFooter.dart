import 'package:betsbi/controller/BottomNavigationController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationOfflineBarFooterState
    extends State<BottomNavigationBarFooter> {
  @override
  void initState() {
    super.initState();
  }

  BottomNavigationBar bottomNavigationBarWithoutCurrentIndex() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CommunityMaterialIcons.google_classroom,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text(SettingsManager.mapLanguage["Lesson"]),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("Memo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.opacity,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("Exercise"),
          ),
        ],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.offlineOnBottomTapped(
                this.widget.selectedBottomIndexOffLine, index, context);
          });
        });
  }

  BottomNavigationBar bottomNavigationBarWithCurrentIndex() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CommunityMaterialIcons.google_classroom,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text(SettingsManager.mapLanguage["Lesson"]),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("Memo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.opacity,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("Exercise"),
          ),
        ],
        currentIndex: this.widget.selectedBottomIndexOffLine,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.offlineOnBottomTapped(
                this.widget.selectedBottomIndexOffLine, index, context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.selectedBottomIndexOffLine == null)
      return bottomNavigationBarWithoutCurrentIndex();
    else
      return bottomNavigationBarWithCurrentIndex();
  }
}
