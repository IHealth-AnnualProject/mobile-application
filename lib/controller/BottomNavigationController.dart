import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/view/ChatListContactView.dart';
import 'package:betsbi/view/ExerciseListView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:betsbi/view/LessonListView.dart';
import 'package:betsbi/view/MemosView.dart';
import 'package:flutter/material.dart';

class BottomNavigationController {
  static int onBottomTapped(
      int currentIndex, int selectedBottomIndex, BuildContext context) {
    switch (selectedBottomIndex) {
      case 0:
        if (currentIndex != 0)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                isPsy: SettingsManager.applicationProperties
                            .isPsy()
                            .toLowerCase() ==
                        'true'
                    ? true
                    : false,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        break;
      case 1:
        if (currentIndex != 1)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AccountPage(
                userId: SettingsManager.applicationProperties.getCurrentId(),
                isPsy: SettingsManager.applicationProperties
                            .isPsy()
                            .toLowerCase() ==
                        'true'
                    ? true
                    : false,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        break;
      case 2:
        if (currentIndex != 2)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ChatListContactPage(),
            ),
            (Route<dynamic> route) => false,
          );
        break;
    }
    return selectedBottomIndex;
  }

  static int offlineOnBottomTapped(
      int currentIndex, int selectedBottomIndex, BuildContext context) {
    switch (selectedBottomIndex) {
      case 0:
        if (currentIndex != 0)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LessonListView(
                isOffLine: true,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        break;
      case 1:
        if (currentIndex != 1)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MemosPage(
                isOffline: true,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        break;
      case 2:
        if (currentIndex != 2) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseListViewPage(
                type: 'math',
                leading: 'assets/math.png',
                isOffLine: true,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
        break;
    }
    return selectedBottomIndex;
  }
}
