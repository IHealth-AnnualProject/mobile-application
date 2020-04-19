
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/material.dart';


class BottomNavigationController{

  static int onBottomTapped(int currentIndex,int selectedBottomIndex, BuildContext context) {
      switch(selectedBottomIndex) {
        case 0:
          if(currentIndex != 0)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case 1:
          if(currentIndex != 1)
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => AccountPage()));
          break;
        case 2:
          break;
      }
      return selectedBottomIndex;
  }
}