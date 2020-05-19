import 'package:betsbi/controller/BottomNavigationController.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BottomNavigationBarFooter.dart';

class BottomNavigationOfflineBarFooterState extends State<BottomNavigationBarFooter> {
  @override
  void initState() {
    super.initState();
  }

  BottomNavigationBar bottomNavigationBarWithoutCurrentIndex() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CommunityMaterialIcons.logout,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("Login"),
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
              Icons.not_listed_location,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("None"),
          ),
        ],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.offlineOnBottomTapped(
                this.widget.selectedBottomIndex, index, context);
          });
        });
  }

  BottomNavigationBar bottomNavigationBarWithCurrentIndex() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CommunityMaterialIcons.logout,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("Login"),
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
              Icons.not_listed_location,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text("None"),
          ),
        ],
        currentIndex: this.widget.selectedBottomIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.offlineOnBottomTapped(
                this.widget.selectedBottomIndex, index, context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.selectedBottomIndex == null)
      return bottomNavigationBarWithoutCurrentIndex();
    else
      return bottomNavigationBarWithCurrentIndex();
  }
}
