import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/view/ChatView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/material.dart';

class BottomNavigationController {
  static int onBottomTapped(
      int currentIndex, int selectedBottomIndex, BuildContext context) {
    switch (selectedBottomIndex) {
      case 0:
        if (currentIndex != 0)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                isPsy: SettingsManager.isPsy.toLowerCase() == 'true'
                    ? true
                    : false,
              ),
            ),
          );
        break;
      case 1:
        if (currentIndex != 1)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountPage(
                userId: SettingsManager.currentId,
                isPsy: SettingsManager.isPsy.toLowerCase() == 'true'
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
              builder: (context) => ChatPage(),
            ),
          );
        break;
    }
    return selectedBottomIndex;
  }
}
