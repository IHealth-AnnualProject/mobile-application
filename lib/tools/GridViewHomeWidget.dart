import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:betsbi/services/legal/view/LegalMentionView.dart';
import 'package:betsbi/services/relaxing/view/AmbianceView.dart';
import 'package:betsbi/services/error/view/ErrorView.dart';
import 'package:betsbi/services/lesson/view/LessonListView.dart';
import 'package:betsbi/services/memo/view/MemosView.dart';
import 'package:betsbi/services/quest/view/QuestView.dart';
import 'package:betsbi/services/settings/view/SettingsView.dart';
import 'package:betsbi/services/shop/view/ShopView.dart';
import 'package:betsbi/services/exercise/view/TrainingView.dart';
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
        textBrick: SettingsManager.mapLanguage["MyAccountContainer"] != null
            ? SettingsManager.mapLanguage["MyAccountContainer"]
            : "",
        destination: AccountPage(
            userId: SettingsManager.applicationProperties.getCurrentId(),
            isPsy: false),
        image: "user.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyTrainingContainer"] != null
            ? SettingsManager.mapLanguage["MyTrainingContainer"]
            : "",
        destination: TrainingPage(),
        image: "training.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyMemosContainer"] != null
            ? SettingsManager.mapLanguage["MyMemosContainer"]
            : "",
        destination: MemosPage(),
        image: "notes.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyAmbianceContainer"] != null
            ? SettingsManager.mapLanguage["MyAmbianceContainer"]
            : "",
        destination: AmbiancePage(),
        image: "exercise.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyQuestContainer"] != null
            ? SettingsManager.mapLanguage["MyQuestContainer"]
            : "",
        destination: QuestPage(),
        image: "quest.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage['Lesson'],
        destination: LessonListPage(),
        image: "knowmore.png"),
    //todo to update
    BrickContainer(
        textBrick: SettingsManager.mapLanguage['StoreContainer'],
        destination: ShopPage(),
        image: "store.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["SettingsContainer"] != null
            ? SettingsManager.mapLanguage["SettingsContainer"]
            : "",
        destination: SettingsPage(),
        image: "settings.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["ErrorContainer"] != null
            ? SettingsManager.mapLanguage["ErrorContainer"]
            : "",
        destination: ErrorPage(),
        image: "error.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["AboutUs"] != null
            ? SettingsManager.mapLanguage["AboutUs"]
            : "",
        destination: LegalMentionPage(),
        image: "aboutUs.png"),
  ];

  final homePsy = [
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyAccountContainer"] != null
            ? SettingsManager.mapLanguage["MyAccountContainer"]
            : "",
        destination: AccountPage(
            userId: SettingsManager.applicationProperties.getCurrentId(),
            isPsy: true),
        image: "user.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyTrainingContainer"] != null
            ? SettingsManager.mapLanguage["MyTrainingContainer"]
            : "",
        destination: TrainingPage(),
        image: "training.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["MyMemosContainer"] != null
            ? SettingsManager.mapLanguage["MyMemosContainer"]
            : "",
        destination: MemosPage(),
        image: "notes.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage['Lesson'],
        destination: LessonListPage(),
        image: "knowmore.png"),
    //todo to update
    BrickContainer(
        textBrick: SettingsManager.mapLanguage['StoreContainer'],
        destination: ShopPage(),
        image: "store.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["SettingsContainer"] != null
            ? SettingsManager.mapLanguage["SettingsContainer"]
            : "",
        destination: SettingsPage(),
        image: "settings.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["ErrorContainer"] != null
            ? SettingsManager.mapLanguage["ErrorContainer"]
            : "",
        destination: ErrorPage(),
        image: "error.png"),
    BrickContainer(
        textBrick: SettingsManager.mapLanguage["AboutUs"] != null
            ? SettingsManager.mapLanguage["AboutUs"]
            : "",
        destination: LegalMentionPage(),
        image: "aboutUs.png"),
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
