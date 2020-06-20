import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/services/account/AccountView.dart';
import 'package:betsbi/services/chat/ChatListContactView.dart';
import 'package:betsbi/services/exercise/ExerciseListView.dart';
import 'package:betsbi/services/home/HomeView.dart';
import 'package:betsbi/services/lesson/LessonListView.dart';
import 'package:betsbi/services/memo/MemosView.dart';
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
          Navigator.push(
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
          );
        break;
      case 2:
        if (currentIndex != 2)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatListContactPage(),
            ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonListView(
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
              builder: (context) => ExerciseListViewPage(
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
