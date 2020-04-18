
import 'package:betsbi/account.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class BottomNavigationController{

  static int onBottomTapped(int currentIndex,int selectedBottomIndex, BuildContext context) {
      switch(selectedBottomIndex) {
        case 0:
          if(currentIndex != 0)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home()));
          break;
        case 1:
          if(currentIndex != 1)
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Account()));
          break;
        case 2:
          break;
      }
      return selectedBottomIndex;
  }
}