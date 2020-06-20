import 'package:badges/badges.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:betsbi/services/chat/view/ChatListContactView.dart';
import 'package:betsbi/services/home/view/HomeView.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
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
            onBottomTapped(
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
            onBottomTapped(
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

  int onBottomTapped(
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
          ).whenComplete(() => this.setState(() { }));
        break;
      case 2:
        if (currentIndex != 2)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatListContactPage(),
            ),
          ).whenComplete(() => this.setState(() { }));
        break;
    }
    return selectedBottomIndex;
  }
}
