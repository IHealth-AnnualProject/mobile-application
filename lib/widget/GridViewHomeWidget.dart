import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/view/AmbianceView.dart';
import 'package:betsbi/view/ErrorView.dart';
import 'package:betsbi/view/MemosView.dart';
import 'package:betsbi/view/QuestView.dart';
import 'package:betsbi/view/SettingsView.dart';
import 'package:betsbi/view/TrainingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BrickContainer.dart';

class GridViewHomeWidget extends StatefulWidget {
  final bool isPsy;

  GridViewHomeWidget({this.isPsy = false});

  @override
  _GridViewPsyWidgetState createState() => _GridViewPsyWidgetState();
}

class _GridViewPsyWidgetState extends State<GridViewHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return this.widget.isPsy ? gridviewPsyView() : gridviewUserView();
  }

  CustomScrollView gridviewPsyView() {
    return CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: <Widget>[
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyAccountContainer"] != null
                          ? SettingsManager.mapLanguage["MyAccountContainer"]
                          : "",
                  iconBrick: Icons.home,
                  destination: AccountPage(
                      userId: SettingsManager.currentId, isPsy: true),
                  image: "user.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyTrainingContainer"] != null
                          ? SettingsManager.mapLanguage["MyTrainingContainer"]
                          : "",
                  iconBrick: Icons.play_for_work,
                  destination: TrainingPage(),
                  image: "training.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyMemosContainer"] != null
                          ? SettingsManager.mapLanguage["MyMemosContainer"]
                          : "",
                  iconBrick: Icons.wrap_text,
                  destination: MemosPage(),
                  image: "notes.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["SettingsContainer"] != null
                          ? SettingsManager.mapLanguage["SettingsContainer"]
                          : "",
                  iconBrick: Icons.settings,
                  destination: SettingsPage(),
                  image: "settings.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(249, 89, 51, 1),
                  textBrick:
                      SettingsManager.mapLanguage["ErrorContainer"] != null
                          ? SettingsManager.mapLanguage["ErrorContainer"]
                          : "",
                  iconBrick: Icons.error,
                  destination: ErrorPage(),
                  image: "error.png"),
            ],
          ),
        ),
      ],
    );
  }

  CustomScrollView gridviewUserView() {
    return CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: <Widget>[
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyAccountContainer"] != null
                          ? SettingsManager.mapLanguage["MyAccountContainer"]
                          : "",
                  iconBrick: Icons.home,
                  destination: AccountPage(
                      userId: SettingsManager.currentId, isPsy: false),
                  image: "user.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyTrainingContainer"] != null
                          ? SettingsManager.mapLanguage["MyTrainingContainer"]
                          : "",
                  iconBrick: Icons.play_for_work,
                  destination: TrainingPage(),
                  image: "training.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyMemosContainer"] != null
                          ? SettingsManager.mapLanguage["MyMemosContainer"]
                          : "",
                  iconBrick: Icons.wrap_text,
                  destination: MemosPage(),
                  image: "notes.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyAmbianceContainer"] != null
                          ? SettingsManager.mapLanguage["MyAmbianceContainer"]
                          : "",
                  iconBrick: Icons.music_note,
                  destination: AmbiancePage(),
                  image: "exercise.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["MyQuestContainer"] != null
                          ? SettingsManager.mapLanguage["MyQuestContainer"]
                          : "",
                  iconBrick: Icons.not_listed_location,
                  destination: QuestPage(),
                  image: "quest.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(51, 171, 249, 1),
                  textBrick:
                      SettingsManager.mapLanguage["SettingsContainer"] != null
                          ? SettingsManager.mapLanguage["SettingsContainer"]
                          : "",
                  iconBrick: Icons.settings,
                  destination: SettingsPage(),
                  image: "settings.png"),
              BrickContainer(
                  colorBrick: Color.fromRGBO(249, 89, 51, 1),
                  textBrick:
                      SettingsManager.mapLanguage["ErrorContainer"] != null
                          ? SettingsManager.mapLanguage["ErrorContainer"]
                          : "",
                  iconBrick: Icons.error,
                  destination: ErrorPage(),
                  image: "error.png"),
            ],
          ),
        ),
      ],
    );
  }
}
