import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:betsbi/services/relaxing/view/AmbianceView.dart';
import 'package:betsbi/services/error/view/ErrorView.dart';
import 'package:betsbi/services/lesson/view/LessonListView.dart';
import 'package:betsbi/services/memo/view/MemosView.dart';
import 'package:betsbi/services/quest/view/QuestView.dart';
import 'package:betsbi/services/settings/view/SettingsView.dart';
import 'package:betsbi/services/shop/view/ShopView.dart';
import 'package:betsbi/services/exercise/view/TrainingView.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'BrickContainer.dart';

class GridViewHomeWidget extends StatefulWidget {
  final bool isPsy;

  GridViewHomeWidget({this.isPsy = false});

  @override
  _GridViewPsyWidgetState createState() => _GridViewPsyWidgetState();
}

class _GridViewPsyWidgetState extends State<GridViewHomeWidget> {
  final homeUser = [
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyAccountContainer"] != null
            ? SettingsManager.mapLanguage["MyAccountContainer"]
            : "",
        iconBrick: Icons.home,
        destination: AccountPage(
            userId: SettingsManager.applicationProperties.getCurrentId(),
            isPsy: false),
        image: "user.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyTrainingContainer"] != null
            ? SettingsManager.mapLanguage["MyTrainingContainer"]
            : "",
        iconBrick: Icons.play_for_work,
        destination: TrainingPage(),
        image: "training.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyMemosContainer"] != null
            ? SettingsManager.mapLanguage["MyMemosContainer"]
            : "",
        iconBrick: Icons.wrap_text,
        destination: MemosPage(),
        image: "notes.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyAmbianceContainer"] != null
            ? SettingsManager.mapLanguage["MyAmbianceContainer"]
            : "",
        iconBrick: Icons.music_note,
        destination: AmbiancePage(),
        image: "exercise.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyQuestContainer"] != null
            ? SettingsManager.mapLanguage["MyQuestContainer"]
            : "",
        iconBrick: Icons.not_listed_location,
        destination: QuestPage(),
        image: "quest.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(249, 89, 51, 1),
        textBrick: SettingsManager.mapLanguage['Lesson'],
        iconBrick: CommunityMaterialIcons.google_classroom,
        destination: LessonListPage(),
        image: "knowmore.png"),
    //todo to update
    BrickContainer(
        colorBrick: Color.fromRGBO(249, 89, 51, 1),
        textBrick: SettingsManager.mapLanguage['StoreContainer'],
        iconBrick: CommunityMaterialIcons.google_classroom,
        destination: ShopPage(),
        image: "knowmore.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["SettingsContainer"] != null
            ? SettingsManager.mapLanguage["SettingsContainer"]
            : "",
        iconBrick: Icons.settings,
        destination: SettingsPage(),
        image: "settings.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(249, 89, 51, 1),
        textBrick: SettingsManager.mapLanguage["ErrorContainer"] != null
            ? SettingsManager.mapLanguage["ErrorContainer"]
            : "",
        iconBrick: Icons.error,
        destination: ErrorPage(),
        image: "error.png"),
  ];

  final homePsy = [
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyAccountContainer"] != null
            ? SettingsManager.mapLanguage["MyAccountContainer"]
            : "",
        iconBrick: Icons.home,
        destination: AccountPage(
            userId: SettingsManager.applicationProperties.getCurrentId(),
            isPsy: true),
        image: "user.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyTrainingContainer"] != null
            ? SettingsManager.mapLanguage["MyTrainingContainer"]
            : "",
        iconBrick: Icons.play_for_work,
        destination: TrainingPage(),
        image: "training.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["MyMemosContainer"] != null
            ? SettingsManager.mapLanguage["MyMemosContainer"]
            : "",
        iconBrick: Icons.wrap_text,
        destination: MemosPage(),
        image: "notes.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(249, 89, 51, 1),
        textBrick: SettingsManager.mapLanguage['Lesson'],
        iconBrick: CommunityMaterialIcons.google_classroom,
        destination: LessonListPage(),
        image: "knowmore.png"),
    //todo to update
    BrickContainer(
        colorBrick: Color.fromRGBO(249, 89, 51, 1),
        textBrick: SettingsManager.mapLanguage['StoreContainer'],
        iconBrick: CommunityMaterialIcons.google_classroom,
        destination: ShopPage(),
        image: "knowmore.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(51, 171, 249, 1),
        textBrick: SettingsManager.mapLanguage["SettingsContainer"] != null
            ? SettingsManager.mapLanguage["SettingsContainer"]
            : "",
        iconBrick: Icons.settings,
        destination: SettingsPage(),
        image: "settings.png"),
    BrickContainer(
        colorBrick: Color.fromRGBO(249, 89, 51, 1),
        textBrick: SettingsManager.mapLanguage["ErrorContainer"] != null
            ? SettingsManager.mapLanguage["ErrorContainer"]
            : "",
        iconBrick: Icons.error,
        destination: ErrorPage(),
        image: "error.png"),
  ];

  GridView gridViewUserOrPsy() {
    return GridView.builder(
      itemCount: this.widget.isPsy ? homePsy.length : homeUser.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
        position: index,
        duration: Duration(milliseconds: 375),
        columnCount: 2,
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: Card(
              child: this.widget.isPsy ? homePsy[index] : homeUser[index],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(child: gridViewUserOrPsy());
  }
}