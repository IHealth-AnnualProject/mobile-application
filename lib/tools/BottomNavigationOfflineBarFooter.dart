import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/exercise/view/ExerciseListView.dart';
import 'package:betsbi/services/lesson/view/LessonListView.dart';
import 'package:betsbi/services/memo/view/MemosView.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
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
            title: Text(SettingsManager.mapLanguage["Exercise"]),
          ),
        ],
        onTap: (int index) {
          setState(() {
            offlineOnBottomTapped(
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
            title: Text(SettingsManager.mapLanguage["Exercise"]),
          ),
        ],
        currentIndex: this.widget.selectedBottomIndexOffLine,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            offlineOnBottomTapped(
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


  int offlineOnBottomTapped(
      int currentIndex, int selectedBottomIndex, BuildContext context) {
    switch (selectedBottomIndex) {
      case 0:
        if (currentIndex != 0)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonListPage(
                isOffLine: true,
              ),
            ),
          ).whenComplete(
                () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MemosPage(
                  isOffline: true,
                ),
              ),
                  (Route<dynamic> route) => false,
            ),
          );
        break;
      case 1:
        if (currentIndex != 1)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemosPage(
                isOffline: true,
              ),
            ),
          ).whenComplete(
                () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MemosPage(
                  isOffline: true,
                ),
              ),
                  (Route<dynamic> route) => false,
            ),
          );
        break;
      case 2:
        if (currentIndex != 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseListPage(
                type: 'Math',
                leading: 'assets/math.png',
                isOffLine: true,
              ),
            ),
          ).whenComplete(
                () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MemosPage(
                  isOffline: true,
                ),
              ),
                  (Route<dynamic> route) => false,
            ),
          );
        }
        break;
    }
    return selectedBottomIndex;
  }
}
