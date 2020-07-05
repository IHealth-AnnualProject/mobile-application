import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:betsbi/services/level/controller/LevelController.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelDialog extends StatelessWidget {
  final int level;

  LevelDialog({@required this.level});

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(SettingsManager.mapLanguage["Cancel"]),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget goToAccountPageButton = FlatButton(
      child: Text(SettingsManager.mapLanguage["MyAccountContainer"]),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AccountPage(
              userId: SettingsManager.applicationProperties.getCurrentId(),
              isPsy: false,
            ),
          ),
        );
      },
    );
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.asset("assets/congrats.gif"),
            DefaultTextTitle(
              title: "Level Up : " + this.level.toString(),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: FutureBuilder(
          future: LevelController.getAllUnlockedOutfits(level: this.level),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return Column(
                  children: <Widget>[
                    DefaultTextTitle(
                        title:
                            SettingsManager.mapLanguage["WhatYouVeUnlocked"]),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.maxFinite,
                      child: ListView(
                        children: snapshot.data,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ],
                );
              } else
                return DefaultTextTitle(
                    title: SettingsManager.mapLanguage["NothingUnlocked"]);
            } else
              return CircularProgressIndicator();
          },
        ),
      ),
      actions: [cancelButton,goToAccountPageButton],
    );
  }
}
