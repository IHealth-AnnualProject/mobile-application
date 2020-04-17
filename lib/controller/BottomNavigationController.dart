
import 'package:betsbi/account.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class BottomNavigationController{

  static int onBottomTapped(int selectedBottomIndex, BuildContext context) {
      print(selectedBottomIndex);
      switch(selectedBottomIndex) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home()));
          break;
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Account()));
          break;
        case 2:
          break;
      }
      return selectedBottomIndex;
  }
}