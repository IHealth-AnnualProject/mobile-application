import 'package:badges/badges.dart';
import 'package:betsbi/controller/BottomNavigationController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarFooterState extends State<BottomNavigationBarFooter> {
  @override
  void initState() {
    super.initState();
  }

  BottomNavigationBar bottomNavigationBarWithoutCurrentIndex() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text(SettingsManager.mapLanguage["HomeFooter"] != null
                ? SettingsManager.mapLanguage["HomeFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text(SettingsManager.mapLanguage["AccountFooter"] != null
                ? SettingsManager.mapLanguage["AccountFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: SettingsManager.applicationProperties.getNewMessage() != 0
                ? Badge(
                    shape: BadgeShape.circle,
                    borderRadius: 100,
                    child: Icon(
                      Icons.chat,
                      color: Color.fromRGBO(255, 195, 0, 1),
                    ),
                  )
                : Icon(
                    Icons.chat,
                    color: Color.fromRGBO(255, 195, 0, 1),
                  ),
            title: Text(SettingsManager.mapLanguage["ChatFooter"] != null
                ? SettingsManager.mapLanguage["ChatFooter"]
                : ""),
          ),
        ],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.onBottomTapped(
                this.widget.selectedBottomIndexOnline, index, context);
          });
        });
  }

  BottomNavigationBar bottomNavigationBarWithCurrentIndex() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text(SettingsManager.mapLanguage["HomeFooter"] != null
                ? SettingsManager.mapLanguage["HomeFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            title: Text(SettingsManager.mapLanguage["AccountFooter"] != null
                ? SettingsManager.mapLanguage["AccountFooter"]
                : ""),
          ),
          BottomNavigationBarItem(
            icon: SettingsManager.applicationProperties.getNewMessage() != 0
                ? Badge(
                    shape: BadgeShape.circle,
                    borderRadius: 100,
                    child: Icon(
                      Icons.chat,
                      color: Color.fromRGBO(255, 195, 0, 1),
                    ),
                  )
                : Icon(
                    Icons.chat,
                    color: Color.fromRGBO(255, 195, 0, 1),
                  ),
            title: Text(SettingsManager.mapLanguage["ChatFooter"] != null
                ? SettingsManager.mapLanguage["ChatFooter"]
                : ""),
          ),
        ],
        currentIndex: this.widget.selectedBottomIndexOnline,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            BottomNavigationController.onBottomTapped(
                this.widget.selectedBottomIndexOnline, index, context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.selectedBottomIndexOnline == null)
      return bottomNavigationBarWithoutCurrentIndex();
    else
      return bottomNavigationBarWithCurrentIndex();
  }
}
